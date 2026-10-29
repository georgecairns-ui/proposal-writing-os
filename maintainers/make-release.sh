#!/bin/bash
#
# MAKE RELEASE
# ------------
# Builds dist/proposal-writing-os.zip: a clean copy of the kit for customers to download.
#
# Run it from the proposal-writing-os folder with:   bash maintainers/make-release.sh
#
# What it does:
#   1. Checks the files that ship are still blank templates, so nobody's real proposals,
#      business notes or setup progress can go out by mistake. Stops if not.
#   2. Copies the kit into a temporary folder called "Proposal Writing OS", leaving out this
#      maintainers folder, git history, old builds, backups and computer clutter.
#   3. Checks the copy is complete and the data file is valid.
#   4. Zips it as dist/proposal-writing-os.zip, replacing any older one.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/proposal-writing-os-build.XXXXXX")"
trap 'rm -rf "$STAGE"' EXIT
NAME="Proposal Writing OS"
OUT="$STAGE/$NAME"

fail() { echo "RELEASE STOPPED: $1" >&2; exit 1; }

# ---------- 1. Is everything that ships still a blank template? ----------
python3 - "$ROOT" <<'PYEOF' || fail "the files above contain real data. Restore them with: git checkout -- apps/proposals/data apps/proposals/brand context setup/progress.md CLAUDE.md"
import json, sys, pathlib, re
root = pathlib.Path(sys.argv[1])
problems = []
data = json.loads((root / "apps/proposals/data/proposals.json").read_text())
for key in ("packages", "extras", "clients", "proposals", "requests", "activity"):
    if data.get(key):
        problems.append("apps/proposals/data/proposals.json has " + key + " in it")
# No demo mode and no sample business ships (the demo lives in ~/Claude/08_Artifacts/Proposal-OS-Demo)
if (root / "apps/proposals/app/demo-data.js").exists():
    problems.append("apps/proposals/app/demo-data.js is back: the demo lives outside the kit")
for f in list((root / "apps").rglob("*.js")) + list((root / "apps").rglob("*.html")) + list((root / "apps").rglob("menu.json")):
    txt = f.read_text(errors="ignore")
    if re.search(r"makeDemoData|makeProposalDemoData|setDemo|isDemo|demo-data\.js|demo-mode|data-action=\"demo|data-change=\"demo|Demo mode", txt):
        problems.append(f"{f.relative_to(root)} still has demo mode in it")
if (data.get("checkIn") or {}).get("lastRunAt"):
    problems.append("apps/proposals/data/proposals.json has a check-in in it")
settings = data.get("settings", {})
if any(settings.get(k) for k in ("yourName", "businessName", "ownSkill", "paymentTerms")):
    problems.append("apps/proposals/data/proposals.json has someone's details in its settings")
if any((settings.get("signOff") or {}).values()) or any((settings.get("brand") or {}).get(k) for k in ("logo", "logoOnColour", "website", "setUp")):
    problems.append("apps/proposals/data/proposals.json has someone's sign-off or brand in it")
if settings.get("proposalsSetUp"):
    problems.append("apps/proposals/data/proposals.json says proposals are set up")
brand = (root / "apps/proposals/brand/brand.css").read_text()
if "--doc-primary:      #2B2B2B;" not in brand:
    problems.append("apps/proposals/brand/brand.css has someone's colours in it")
extra_brand = [f.name for f in (root / "apps/proposals/brand").iterdir() if f.name not in ("brand.css", ".DS_Store")]
if extra_brand:
    problems.append("apps/proposals/brand/ has someone's files in it: " + ", ".join(extra_brand))
clients = [f.name for f in (root / "files/02-clients").iterdir() if f.name not in ("README.md", ".DS_Store")]
if clients:
    problems.append("files/02-clients/ has client folders in it")
for f in sorted((root / "context").glob("*.md")):
    if f.name != "README.md" and "Status: not filled in yet" not in f.read_text():
        problems.append(f"{f.relative_to(root)} has been filled in")
if [f.name for f in (root / "skills-to-upload").iterdir() if f.name not in ("README.md", ".DS_Store")]:
    problems.append("skills-to-upload/ has someone's own skills in it")
if "(Claude fills this in during setup)" not in (root / "skills-to-upload/README.md").read_text():
    problems.append("skills-to-upload/README.md lists someone's own skills")
if "Setup status: not started" not in (root / "setup/progress.md").read_text():
    problems.append("setup/progress.md is not blank")
# The shipped permissions never include a tool that sends, deletes or posts (setup adds the one
# send tool the person agrees to, in their own settings.local.json)
perms = json.loads((root / ".claude/settings.json").read_text()).get("permissions", {}).get("allow", [])
if any(re.search(r"send|delete|trash|post|forward|reply", p, re.I) and p.startswith("mcp__") for p in perms):
    problems.append(".claude/settings.json pre-approves a tool that sends, deletes or posts")
if "Setup: not done yet" not in (root / "CLAUDE.md").read_text():
    problems.append("CLAUDE.md says setup is done")
# A person's own photos and videos never ship: apps/<tool>/data/media may hold nothing but a .gitkeep
for f in sorted((root / "apps").glob("*/data/media/**/*")):
    if f.is_file() and f.name != ".gitkeep":
        problems.append(f"{f.relative_to(root)} is a person's own photo or video and must not ship")
# A customer's saved downloads never ship: setup/as-installed/ holds only its README
for f in sorted((root / "setup/as-installed").rglob("*")):
    if f.is_file() and f.name not in ("README.md", ".DS_Store"):
        problems.append(f"{f.relative_to(root)} is a customer's saved download and must not ship")
# The shared version in toolkit.json must be the one in apps/shared/VERSION
shared_version = (root / "apps/shared/VERSION").read_text().split()[0]
if str(json.loads((root / "toolkit.json").read_text()).get("sharedVersion")) != shared_version:
    problems.append(f"toolkit.json sharedVersion is {json.loads((root / 'toolkit.json').read_text()).get('sharedVersion')!r} but apps/shared/VERSION says {shared_version}: change them together")
# Shared parts are identical in every tool, so they must not name one. No file may use the old start-up names,
# and no message in the scripts, the helper or the shared page code may say "Proposal Writing OS" (they read the tool's name from toolkit.json)
skip_dirs = {".git", "dist", "maintainers", "node_modules"}
for f in sorted(root.rglob("*")):
    if not f.is_file() or skip_dirs & set(f.relative_to(root).parts) or f.suffix in (".png", ".jpg", ".woff2", ".zip", ".gz", ".ico"):
        continue
    txt = f.read_text(errors="ignore")
    rel = str(f.relative_to(root))
    if "raw.githubusercontent.com" in txt:
        problems.append(f"{rel} uses raw.githubusercontent.com: read files from the downloaded copy instead")
    # Shared version 13: setup never gives up on a connection, never asks what's on screen, and never uses keys or GitHub sign-in
    v13_scope = rel == "START-HERE.md" or rel == "README.md" or rel.startswith("setup/") or rel.startswith(".claude/skills/connect-a-tool/") or rel.startswith(".claude/skills/get-updates/")
    # The give-up checks apply only to the files that connect apps (elsewhere "move on" or "skip it" is harmless)
    connect_scope = (re.fullmatch(r"setup/0[2-4][^/]*\.md", rel) or re.fullmatch(r"setup/[^/]*(connect|check-ins|make-it-automatic)[^/]*\.md", rel)
                     or re.fullmatch(r"setup/connections/[^/]+\.md", rel) or rel.startswith(".claude/skills/connect-a-tool/")
                     or rel == "setup/proposals-04-your-client-folders.md")
    if v13_scope and f.suffix == ".md" and rel != "setup/connections/xero-drafts.md":
        give_up = (
            (r"and (move|carry) on\b(?! (from|setting up))", "lets Claude give up on a step"),
            (r"\bthen move on\b", "lets Claude give up on a step"),
            (r"\bskip it\b", "lets Claude give up on a step"),
            (r"try once more", "lets Claude give up on a connection"),
            (r"ask (the person |them )?what they (actually |can )?see", "asks the person what's on screen: Claude checks the connection status itself"),
        ) if connect_scope else ()
        for pattern, why in give_up + (
            (r"Route 2: API key", "offers an API key route"),
            (r"claude mcp add", "adds a server outside Claude's Connectors screen"),
            (r"save-key", "asks for a key"),
            (r"\bgh (auth|api|repo)\b", "needs a GitHub sign-in while the tools are public"),
        ):
            if re.search(pattern, txt, re.I):
                problems.append(f"{rel} {why} (shared version 13): matched {pattern!r}")
    for old in ("open-task-list", "start-task-list"):
        if old in txt:
            problems.append(f"{rel} uses the old name {old} (it is now open-the-app / start-app, the same in every tool)")
    if re.match(r"setup/scripts/|apps/server/|apps/shared/js/", rel) and re.search(r"Proposal Writing OS|(?<!window\.)TaskListOS", txt):
        problems.append(f"{rel} names a tool (Proposal Writing OS): shared parts read the name from toolkit.json")
for p in problems:
    print("  - " + p, file=sys.stderr)
sys.exit(1 if problems else 0)
PYEOF

# ---------- 2. Copy, leaving out what customers don't need ----------
mkdir -p "$OUT" "$DIST"
rsync -a \
  --include 'setup/as-installed/README.md' --exclude 'setup/as-installed/*' \
  --exclude '.git' --exclude '.gitignore' --exclude 'dist' --exclude 'maintainers' \
  --exclude '.claude/launch.json' --exclude '.claude/settings.local.json' --exclude '.claude/.cc-writes' \
  --exclude '*.backup.json' --exclude 'apps/home/data' --exclude '.DS_Store' --exclude '._*' --exclude 'Thumbs.db' --exclude 'desktop.ini' \
  "$ROOT/" "$OUT/"
# Claude Code can leave empty .claude folders around the kit while it works; only the top one ships
find "$OUT" -mindepth 2 -type d -name .claude -empty -prune -exec rm -rf {} +

# ---------- 3. Checks ----------
for f in "START-HERE.md" "CLAUDE.md" "Open Proposals.html" "apps/proposals/index.html" "apps/proposals/data/proposals.json" "apps/proposals/menu.json" "apps/proposals/home-boxes.js" "apps/proposals/claude-jobs.json" "apps/proposals/CLAUDE.md" "apps/proposals/ATTACH-CLAUDE.md" "apps/proposals/brand/brand.css" "apps/proposals/app/app.js" "apps/proposals/app/doc.js" "apps/proposals/app/model.js" "setup/progress.md" ".claude/skills/README.md" ".claude/settings.json" ".claude/skills/write-a-proposal/SKILL.md" ".claude/skills/check-client-folders/SKILL.md" ".claude/skills/change-a-proposal/SKILL.md" ".claude/skills/follow-up-a-proposal/SKILL.md" ".claude/skills/import-a-proposal-template/SKILL.md" ".claude/skills/build-my-proposal-skill/SKILL.md" ".claude/skills/proposals-check-in/SKILL.md" ".claude/skills/sort-proposals-brain-dump/SKILL.md" "setup/scripts/save-key.sh" "setup/scripts/start-app.sh" "apps/server/server.js" "apps/server/server.py" "setup/connections/README.md" "toolkit.json" "ATTACHING.md" "apps/installed.json" "apps/shared/catalogue.json" "apps/shared/VERSION" "apps/shared/sidebar.css" "apps/shared/js/sidebar.js" "apps/shared/js/theme.js" "apps/shared/js/braindump.js" "apps/shared/js/connections.js" "apps/shared/js/connections-box.js" ".claude/skills/sort-brain-dump/SKILL.md" "apps/shared/images/claude-icon.png" "apps/home/index.html" "apps/home/home.js" "apps/home/home.css" "apps/shared/fonts/Figtree-Variable.woff2" "apps/shared/fonts/SourceSerif4-Variable.woff2" "context/sales.md" "context/proposals.md" "files/02-clients/README.md" "setup/proposals-01-your-brand.md" "setup/proposals-02-what-you-sell.md" "setup/proposals-03-your-templates.md" "setup/proposals-04-your-client-folders.md" "setup/proposals-05-your-proposal-skill.md" "setup/proposals-06-first-proposal.md" "setup/06-build-your-skills.md" "setup/09-check-and-hand-over.md" "skills-to-upload/README.md" "setup/as-installed/README.md" ".claude/skills/get-updates/SKILL.md"; do
  [ -e "$OUT/$f" ] || fail "missing $f"
done
for f in apps/proposals/data/proposals.json apps/proposals/menu.json apps/proposals/claude-jobs.json toolkit.json apps/installed.json apps/shared/catalogue.json; do
  python3 -c 'import json,sys; json.load(open(sys.argv[1]))' "$OUT/$f" || fail "$f is not valid"
done
# A fresh download lists only Proposal Writing OS, and no test tool ever ships
python3 -c 'import json,sys; t=json.load(open(sys.argv[1]))["tools"]; sys.exit(0 if [x["id"] for x in t]==["proposals"] else 1)' "$OUT/apps/installed.json" || fail "apps/installed.json must list only Proposal Writing OS"
[ ! -e "$OUT/apps/test-tool" ] || fail "the test tool is in the release"
if grep -rIl $'—' "$OUT" >/dev/null 2>&1; then fail "an em dash slipped in: $(grep -rIl $'—' "$OUT" | head -3)"; fi
SKILLS=$(find "$OUT/.claude/skills" -name SKILL.md | wc -l | tr -d ' ')

# ---------- 4. Zip (COPYFILE_DISABLE stops macOS adding hidden ._ files) ----------
rm -f "$DIST/proposal-writing-os.zip"
(cd "$STAGE" && COPYFILE_DISABLE=1 zip -rqX "$DIST/proposal-writing-os.zip" "$NAME")
echo "Built dist/proposal-writing-os.zip ($(du -h "$DIST/proposal-writing-os.zip" | cut -f1 | tr -d ' '), $SKILLS skills)"
