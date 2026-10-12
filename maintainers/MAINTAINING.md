# Maintaining Proposal OS

For people developing the kit itself. Customers never need this folder, but it is public on GitHub, so keep it free of anything private.

## What this project is

Proposal OS is tool 3 of the small business toolkit (planned as "Proposal Writer OS"), built the same way as Task List OS (`~/Repos/getaipowers/task-list-os`, the reference build) and Pipeline OS. A small business owner asks Claude to clone it, opens it in Claude Code and types `/setup`. Claude follows `START-HERE.md`: it learns their brand from their website and logo, their packages and prices (required), and any proposal template they have; connects their email and call recorder; sets up a folder per client in `files/02-clients/`; builds their own proposal skill; and writes a first proposal. From then on the person drops things into a client's folder and presses **Write proposal** in the app (`apps/proposals/`), and the helper starts Claude straight away.

`maintainers/BUILD-PROMPT.md` is the original brief. George's decisions on 12 October 2026, which change it:
- Called **Proposal OS**, in the repository `proposal-writing-os` (George chose the repository name on 21 October 2026; the catalogue entry is renamed, see `SHARED-CATALOGUE-RENAME.md`).
- **One folder per client is the heart of it.** Claude keeps each client's folder complete (summaries of their emails and calls), and Write proposal is one click.
- Setup asks for the logo, colours, website, call recordings, email and proposal templates, then **rebuilds the proposal skill**: a skill named after their business (`build-my-proposal-skill`), saved in `.claude/skills/` and zipped in `skills-to-upload/`.
- Every proposal tells one story: cover, opening note, contents, then about the client, their pain, how it's solved, how it's delivered, options with one recommended, next steps and onboarding. Terms only if they have their own.
- A full toolkit tool (the app, the shared sidebar, attaching). Output is a branded page in the app that saves as an A4 PDF. Prices come only from their saved packages.

## Stack

- Same as Task List OS: no framework, no build step, nothing from the internet. Shared parts (`apps/server/`, `apps/shared/`, `apps/home/`, `setup/scripts/`, `setup/connections/`, the shared skills) are copied byte for byte from Pipeline OS's `main` (shared version 6). Never change them here: change them in Task List OS, raise the shared version, copy them to every tool. The one exception, for now, is the Proposal OS line in `apps/shared/catalogue.json` (see `SHARED-CATALOGUE-RENAME.md`).
- `apps/proposals/`: `index.html`, `menu.json` (Proposals, Clients, Packages, and the Home scripts), `home-boxes.js`, `claude-jobs.json` (the 3 jobs the app can ask the helper to run: `write-proposals`, `change-proposals`, `check-folders`), `CLAUDE.md` (the data format and Claude's rules), `ATTACH-CLAUDE.md`, `data/proposals.json` (blank template), `brand/brand.css` (how proposals look: the first block is the business's colours and fonts).
- `apps/proposals/app/`: `model.js` (data shape, sections, every price, VAT and total, every change), `doc.js` (a proposal laid out as A4 pages, editable in place), `components.js`, `links.js` (opening an email; email only), `view-proposals.js`, `view-clients.js`, `view-packages.js`, `view-proposal.js` (the document and its side panel), `view-preferences.js`, `app.js` (store, routing, actions, the request-to-Claude loop, editing in place, printing, search, shortcuts), `app.css` (Task List OS's stylesheet plus Proposal OS's pieces at the end).
- How "one click" works: the app can't look inside folders (the helper only serves `apps/`), so Claude lists each client folder's contents in `clients`. Buttons add a request to `requests` and call `/api/claude/run/proposals/<job>`; the job's skill does every waiting request of its kind and marks it done with a `note` the app shows.
- Printing: `brand.css` has the print rules (only `.doc` prints, A4, no margins, one section per page). The phone layout is `@media screen` only, so it never applies when printing.
- Claude's side: `START-HERE.md`, `CLAUDE.md`, `setup/` (shared steps adapted for proposals, plus `proposals-01` to `proposals-06`), `.claude/skills/` (`write-a-proposal`, `check-client-folders`, `change-a-proposal`, `follow-up-a-proposal`, `import-a-proposal-template`, `build-my-proposal-skill`, `proposals-check-in`, `sort-proposals-brain-dump`, plus the shared ones), `context/sales.md`, `context/proposals.md`.
- No demo mode (shared version 6). The sample business for the shareable demo page (Fern & Finch) lives in `~/Claude/08_Artifacts/Proposal-OS-Demo/`, with the script that builds the page from the published kit.

## Commands

- Run the app: `node apps/server/server.js` (or `python3 apps/server/server.py`), then open http://localhost:4747/proposals/.
- Test: by hand, see `maintainers/TESTING.md`. Point `TLOS_CLAUDE` at a stand-in script to test the Write proposal loop without using Claude.
- Check a release: `bash maintainers/make-release.sh`.
- Publish: by pull request, the same as Task List OS and Pipeline OS. Start every change on a `claude/...` branch made from `origin/main`, run the release check, push the branch and open a pull request into `main` for George to merge. Nobody pushes to `main` directly. After the merge, refresh the Drive copy with `git archive origin/main`.

## Rules

- Same as Task List OS: anything committed ships, so never commit real proposals, filled-in `context/`, a ticked `setup/progress.md` or "Setup: complete"; every change goes through `store.update()`; read and draft only; no em dashes; British English; no prices for Get AI Powers services.
- Every number the person relies on (each option's price, VAT, totals, what's out, won this month, win rate) is worked out in `model.js` from the packages. Claude never writes a number for the app to show. `customPrice` on an option is set only by the person, in the app.
- In-place editing can only change words: `EDITABLE` in `model.js` lists the paths allowed. Never prices, ids or statuses.
- Claude never sends anything. The covering email and follow-ups open in the person's own email for them to send. Nothing that sends, deletes or posts is pre-approved (the release check enforces it).
- Claude never writes legal terms; the Terms section shows only their own, and is left out of the print and the contents when empty.

## Open questions for George

- **The catalogue rename** ("Proposal Writer OS" to "Proposal OS", repository `proposal-writer-os` to `proposal-writing-os`) needs to reach Task List OS and Pipeline OS too, or their locked menu entry and attach instructions point at a repository that doesn't exist. See `SHARED-CATALOGUE-RENAME.md`. `ATTACHING.md` is unchanged here (it's identical in every tool) and still says `proposal-writer-os`; it changes everywhere at once.
- **Client folders outside the kit** (a synced Google Drive or Dropbox folder elsewhere on the computer) are read by Claude where they are, but the app can only show their path. Moving the helper to list those folders would be a shared change.
- **Word output.** Proposals are a branded page and a PDF. A Word copy for people who live in Word was considered and left out for now.
- The licence hasn't been reviewed by a solicitor (same as the other tools).
