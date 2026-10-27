/*
  Checks the proposals model (apps/proposals/app/model.js): the price snapshot, pence and the sentAt fix.
  Run: node maintainers/test-model.js
  It loads model.js with a tiny stand-in for the browser, so nothing is written anywhere.
  Exits 1 if any check fails.
*/
"use strict";

const assert = require("assert");
const fs = require("fs");
const path = require("path");
const vm = require("vm");

const dir = path.join(__dirname, "..", "apps", "proposals", "app");
const ui = {
  isoDate: function (d) { return d.toISOString().slice(0, 10); },
  parseDate: function (s) { return new Date(s + "T12:00:00Z"); },
  addDays: function (d, n) { return new Date(new Date(d).getTime() + n * 86400000); },
  makeId: function (p) { return p + "-test"; }
};
const sandbox = { window: { TaskListOS: { ui: ui } }, console: console };
vm.createContext(sandbox);
vm.runInContext(fs.readFileSync(path.join(dir, "model.js"), "utf8"), sandbox, { filename: "model.js" });
const M = sandbox.window.PO.model;

let failed = 0;
function test(name, fn) {
  try { fn(); console.log("ok   " + name); } catch (e) { failed++; console.log("FAIL " + name + "\n     " + e.message); }
}
const clone = function (x) { return JSON.parse(JSON.stringify(x)); };

// A data file as it was before the snapshot existed: options hold only a packageId
function oldFile() {
  const opt = function (id, rec) { return { packageId: id, recommended: !!rec, why: "x" }; };
  const prop = function (id, status, pkgId) { return { id: id, status: status, title: id, createdAt: "2026-09-01T10:00:00Z", sentAt: "2026-09-02T10:00:00Z", sections: { investment: { options: [opt(pkgId, true)], extras: [] } } }; };
  return {
    formatVersion: 1,
    settings: { vatRegistered: true, vatRate: 20 },
    packages: [
      { id: "pk-site", name: "Website", price: 3000.5, billing: "one-off", includes: ["5 pages"] },
      { id: "pk-ret", name: "Retainer", price: 500, billing: "monthly", months: 12 },
      { id: "pk-day", name: "Workshop", price: 600, billing: "per-day" },
      { id: "pk-gone", name: "Old thing", price: 1000, billing: "one-off" }
    ],
    proposals: [prop("sent-site", "sent", "pk-site"), prop("won-ret", "won", "pk-ret"), prop("draft-site", "draft", "pk-site"), prop("lost-gone", "lost", "pk-gone"), prop("appr", "approved", "pk-site"), prop("sent-day", "sent", "pk-day")]
  };
}
function figures(d, id) {
  const p = M.proposalById(d, id);
  const pr = M.optionPrice(d, p.sections.investment.options[0]);
  return pr && { unit: pr.unit, months: pr.months, total: pr.total, vat: pr.vat, gross: pr.gross, name: pr.pkg.name };
}

test("an old file loads with exactly the same numbers", function () {
  const before = M.normalise(clone(oldFile()));
  // Figures an old (live price) version would have worked out, written out by hand
  assert.deepStrictEqual(figures(before, "sent-site"), { unit: 3000.5, months: 0, total: 3000.5, vat: 600.1, gross: 3600.6, name: "Website" });
  assert.deepStrictEqual(figures(before, "won-ret"), { unit: 500, months: 12, total: 6000, vat: 1200, gross: 7200, name: "Retainer" });
  assert.strictEqual(M.proposalValue(before, M.proposalById(before, "draft-site")), 3000.5);
  assert.strictEqual(M.proposalValue(before, M.proposalById(before, "won-ret")), 6000);
});

test("sent, won, lost and approved proposals get a snapshot on first load; drafts do not", function () {
  const d = M.normalise(clone(oldFile()));
  ["sent-site", "won-ret", "lost-gone", "appr"].forEach(function (id) {
    assert.ok(M.proposalById(d, id).sections.investment.options[0].snapshot, id + " has a snapshot");
  });
  assert.strictEqual(M.proposalById(d, "draft-site").sections.investment.options[0].snapshot, undefined);
  assert.strictEqual(M.proposalById(d, "won-ret").sections.investment.options[0].snapshot.months, 12);
});

test("editing a package price does not move a sent proposal, but does move a draft", function () {
  const d = M.normalise(clone(oldFile()));
  const was = figures(d, "sent-site");
  const edited = clone(d.packages); edited.find(function (p) { return p.id === "pk-site"; }).price = 4500;
  M.mut.setPackages(d, edited, d.extras, {});
  M.normalise(d);
  assert.deepStrictEqual(figures(d, "sent-site"), was);
  assert.deepStrictEqual(figures(d, "appr").unit, 3000.5);
  assert.strictEqual(figures(d, "draft-site").unit, 4500);
});

test("removing a package keeps the option on sent, won and lost proposals", function () {
  const d = M.normalise(clone(oldFile()));
  const was = figures(d, "lost-gone"), wasWon = figures(d, "won-ret");
  M.mut.setPackages(d, d.packages.filter(function (p) { return p.id !== "pk-gone" && p.id !== "pk-ret"; }), d.extras, {});
  M.normalise(d);
  assert.deepStrictEqual(figures(d, "lost-gone"), was);
  assert.deepStrictEqual(figures(d, "won-ret"), wasWon);
  assert.strictEqual(M.proposalById(d, "won-ret").sections.investment.options.length, 1);
});

test("a draft is snapshotted when it is approved or sent, and keeps its price after", function () {
  const d = M.normalise(clone(oldFile()));
  M.mut.setStatus(d, "draft-site", "approved");
  assert.ok(M.proposalById(d, "draft-site").sections.investment.options[0].snapshot);
  d.packages.find(function (p) { return p.id === "pk-site"; }).price = 1;
  assert.strictEqual(figures(d, "draft-site").unit, 3000.5);
});

test("a custom price still wins over the snapshot", function () {
  const d = M.normalise(clone(oldFile()));
  M.mut.setCustomPrice(d, "sent-site", 0, "2500.25");
  const pr = M.optionPrice(d, M.proposalById(d, "sent-site").sections.investment.options[0]);
  assert.strictEqual(pr.unit, 2500.25);
  assert.strictEqual(pr.custom, true);
});

test("swapping the package on an option takes a fresh snapshot", function () {
  const d = M.normalise(clone(oldFile()));
  M.proposalById(d, "sent-site").sections.investment.options[0].packageId = "pk-ret";
  M.normalise(d);
  assert.strictEqual(figures(d, "sent-site").name, "Retainer");
});

test("sentAt is kept when going back to sent from won or lost", function () {
  const d = M.normalise(clone(oldFile()));
  M.mut.setStatus(d, "won-ret", "sent");
  assert.strictEqual(M.proposalById(d, "won-ret").sentAt, "2026-09-02T10:00:00Z");
  M.mut.setStatus(d, "won-ret", "won");
  M.mut.setStatus(d, "won-ret", "sent");
  assert.strictEqual(M.proposalById(d, "won-ret").sentAt, "2026-09-02T10:00:00Z");
  // A proposal that was never sent gets a date the first time
  delete M.proposalById(d, "draft-site").sentAt;
  M.mut.setStatus(d, "draft-site", "sent");
  assert.ok(M.proposalById(d, "draft-site").sentAt && M.proposalById(d, "draft-site").sentAt !== undefined);
});

test("pence survive: a 0.5 price, a custom price with pence and VAT to the penny", function () {
  const d = M.normalise(clone(oldFile()));
  const pr = M.optionPrice(d, M.proposalById(d, "sent-site").sections.investment.options[0]);
  assert.strictEqual(M.money(d, pr.unit), "£3,000.50");
  assert.strictEqual(M.money(d, pr.gross, { pence: true }), "£3,600.60");
});

test("the packages and doc screens accept pence (step 0.01, never step 1)", function () {
  ["view-packages.js", "doc.js"].forEach(function (f) {
    const src = fs.readFileSync(path.join(dir, f), "utf8");
    assert.ok(!/type="number"[^>]*step="1"[^>]*(name="price"|data-custom-price)/.test(src) && !/(name="price"|data-custom-price)[^>]*step="1"/.test(src), f + " still has step 1 on a price");
    assert.ok(/step="0\.01"/.test(src), f + " has step 0.01");
  });
});

test("day and hourly rates are left out of the totals", function () {
  const d = M.normalise(clone(oldFile()));
  const p = M.proposalById(d, "sent-day");
  assert.strictEqual(M.proposalValue(d, p), 0);
  assert.ok(M.proposalRate(d, p));
  const n = M.numbers(d);
  assert.strictEqual(n.sentRates, 1);
  assert.strictEqual(n.sentValue, 3000.5);
});

if (failed) { console.log("\n" + failed + " failed"); process.exit(1); }
console.log("\nAll passed");
