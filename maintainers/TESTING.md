# Testing Proposal OS

How to test the whole thing as a customer would, without touching the repository. Also follow section 5 of `SHARED-V3-CHANGES.md` and the testing sections of `SHARED-V4-CHANGES.md` to `SHARED-V6-CHANGES.md` for the shared parts.

## 1. Make a fresh copy

Never test inside the repository: setup writes real details into it. Run the release check, then copy the kit somewhere else without its history:

```bash
bash maintainers/make-release.sh
```

Then unzip `dist/proposal-writing-os.zip` into a test location, for example `Documents/Proposal OS test`. Each test run starts from a fresh unzip.

## 2. Run setup as a customer

1. Open Claude Code in the test folder and type `/setup`.
2. Answer as a real small business owner would, with a real public website (yours, or a friendly business's). A test Gmail account is ideal: send it 2 or 3 client threads (one where the client confirms a budget and a start date), and a newsletter (which Claude should ignore). Drop in a logo and an old proposal as a PDF or Word file.
3. In step 3 (what you sell), refuse to give prices. Setup must explain why they're needed, then carry on without ticking the step. Proposals must not appear with made-up prices.
4. Stop halfway and start a new conversation with "carry on setting up". It should pick up from `setup/progress.md`.

## 3. What to check

**Setup**
- [ ] Claude reads the website before asking, and drafts the brand and packages from it. Guesses are marked as guesses.
- [ ] `brand.css`'s first block has the website's colours and passes contrast on the cover; the logo shows on the cover and every page.
- [ ] The imported template's order and headings become `settings.sections`; its standard wording is in `context/proposals.md`, word for word.
- [ ] Each live client has a folder with summaries of their emails and calls (no whole threads), and a card on the Clients page.
- [ ] Their own proposal skill exists in `.claude/skills/<business>-proposals/` and as a zip in `skills-to-upload/`, stands on its own (no paths into this folder) and holds the real packages and prices.
- [ ] The first proposal tells the full story, uses the client's own words, recommends one option with a reason, and has no number that isn't theirs. Anything nobody said is in "Claude couldn't find".
- [ ] It never asks for a password or key in chat, and no jargon reaches the customer.

**The app**
- [ ] Clients: press **Write proposal**. The card says Claude is writing; within a few minutes the proposal appears and a message offers to open it. With `TLOS_AUTO_CLAUDE=off`, the request waits and **Open in Claude** appears.
- [ ] **New proposal** with a new name and pasted notes: the client and its folder appear, and a proposal is written.
- [ ] **Check for new folders** after adding a folder by hand: the new client appears (and gets a proposal if "write a proposal when a new client folder appears" is on).
- [ ] On a proposal: click words and change them (saved when you click away), Recommend the other option, set a Price for this proposal (totals and VAT follow), **Ask Claude** to make it shorter (only the words change), **Approve**, **Save as PDF** (clean A4 pages, colours printed, no buttons or empty boxes; the Terms page only if there are terms), **Open the covering email** (opens written and addressed), **I've sent it**, then **Won** and **Lost** with a reason, and Undo on each.
- [ ] A sent proposal older than the nudge days shows "Time for a nudge"; after a check-in, **Open the follow-up** opens a written follow-up.
- [ ] Packages: add, change and remove a package and an extra; VAT on and off; payment terms show under the prices.
- [ ] Preferences: rename, reorder and switch off sections (the proposal and its contents follow), change the sign-off, refuse a client folder outside the kit. Save and reload: all kept.
- [ ] Fresh install (blank file): Proposals, Clients and the first Home box show "Let's set up your proposals" with /setup to copy; nothing mentions a demo.
- [ ] Light and dark on every page (proposals stay white); 375, 768, 1024, 1440 and 2560 pixels wide: nothing runs off the side.

**Home**
- [ ] On its own, Proposal OS's Home boxes start switched on. Attached to Task List OS or Pipeline OS, they start switched off and show in Customise's hidden list.

## 4. Attached to Task List OS and Pipeline OS

On a scratch copy of Pipeline OS (or Task List OS), follow `ATTACHING.md` to attach this tool, then check:
- [ ] All the tools show as dropdowns in the sidebar; Home offers every tool's boxes; nothing in the other tools broke.
- [ ] Setup didn't ask what the business sells again (it used `context/sales.md`).
- [ ] A deal with a call written up becomes a ready client; its proposal uses the deal's call and deal check.
- [ ] Marking a proposal sent adds a suggestion in the pipeline to move the deal; nothing moves without a click.
- [ ] A proposal ready to check and a follow-up due appear as suggested tasks in the task list with `source.tool` set to `proposals`.
- [ ] One check-in runs every tool's steps.
