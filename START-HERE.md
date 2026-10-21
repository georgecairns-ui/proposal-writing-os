# Start here

> **If you're a person reading this:** you don't need to do anything in this file. Open this folder in Claude Code and type **/setup** (or say "Read START-HERE.md and set me up"). Claude asks for your website, logo and colours, your packages and prices, and any proposal you'd like it to copy, connects your email and call recorder, then writes your first proposal from a real client. Most people are done in about 20 minutes. The first time you open the folder, Claude Code asks whether you trust it: choose **Yes, I trust this folder** (down arrow, then Enter). That lets Claude write your proposals and notes without asking every time; it still can't send or delete anything.

---

**Claude, this file is for you.** The person you work for has copied Proposal Writing OS onto their computer and wants it set up.

**If you've only just copied it for them** (you're running in a different folder, such as their home or Documents folder): setup must run from inside the Proposal Writing OS folder, because that's where your skills, permissions and their proposals live. Copy it with `git clone https://github.com/georgecairns-ui/proposal-writing-os.git "$HOME/Documents/Proposal Writing OS"` (on Windows, into their Documents folder the same way). If git isn't installed, tell them in one sentence and help them install it. Then give them the one line to open it, `cd ~/Documents/"Proposal Writing OS" && claude` (in the Claude desktop app: open the Code tab and choose that folder), tell them to pick "Yes, I trust this folder", then type `/setup`. Stop there; don't start the setup from the wrong folder. Follow this file, then the step files in `setup/`, in order.

## What Proposal Writing OS is

Proposals that write themselves, in the business's own brand, run by you, with an app on top.

- **One folder per client.** Everything about a client lives in their own folder (`files/02-clients/<client>/`): call notes, transcripts, emails, their brief, anything. The person drops things in; you keep each folder complete by saving in summaries of the client's emails and calls.
- **One click.** On the app's Clients page they press **Write proposal** (or **New proposal**, and paste a few lines). You read everything about that client and write the whole proposal. New client folders get a proposal by themselves if they want that.
- **Every proposal tells the same story**: who the client is, what's hurting them (in their own words), how the business will fix it, how it'll be delivered, the options with one recommended, and the next steps to get started. A cover, a short opening note and a contents page come first.
- **In their brand.** Their logo, colours and fonts, from their website or brand guidelines. If they have a proposal template, you copy its order, headings and wording.
- **Their prices, never guesses.** Their packages and prices are saved once; the app works out every option's price, VAT and total. Anything a client wants that isn't priced is flagged for them.
- **Their own proposal skill.** Setup ends by building a skill named after their business that holds all of this, so every proposal comes out the way they'd write it, here and in Claude everywhere else.
- They check it in the **app** at **http://localhost:4747**, change any words by clicking on them, ask you to change anything else, approve it, save it as an A4 PDF and send it themselves. You write a follow-up when a sent proposal goes quiet.

This folder is their workspace from now on: `context/` holds what you know about the business (`context/sales.md` is what they sell, and `context/proposals.md` how they write proposals and start with new clients), `files/` their documents (with a folder per client in `files/02-clients/`), `.claude/skills/` your saved know-how (they work as commands like `/write-a-proposal`), and `skills-to-upload/` the skills you build for them, packed up for them to add to Claude.

## Before you begin

1. Read `setup/progress.md`. If some steps are ticked, say hello, remind them where you got to, and carry on from the first unticked step.
2. Read `CLAUDE.md` in this folder: the standing rules.
3. If setup is already complete, don't run it again. Ask what they'd like to do.

## The steps

| Step | File | What happens | Their time |
|---|---|---|---|
| 1 | `setup/01-quick-questions.md` | One message of quick questions: their website, logo and colours, email, call recorder, any proposal templates, where client files live | 2 min |
| 2 | `setup/proposals-01-your-brand.md` | You learn their brand from their website and logo and put it on the app and every proposal. They say yes or tweak it | 2 min |
| 3 | `setup/proposals-02-what-you-sell.md` | **Required.** Their packages and prices, VAT, payment terms, how they deliver and what happens when someone says yes. You draft it all from their website first; they correct it | 5 min |
| 4 | `setup/proposals-03-your-templates.md` | Import any proposal or template they'd like you to copy | 2 min |
| 5 | `setup/02-connect-email-and-calendar.md` | Connect email (so you can read what clients confirmed in writing) | 2 min |
| 6 | `setup/03-connect-call-recordings.md` | Connect their call recorder, if they have one | 2 min |
| 7 | `setup/05-get-to-know-the-business.md` | Fill in the rest of your notes and learn how they write | 3 min |
| 8 | `setup/proposals-04-your-client-folders.md` | Set up a folder per client and fill each from their email and calls | 2 min |
| 9 | `setup/proposals-05-your-proposal-skill.md` | Build their own proposal skill, saved here and packed in `skills-to-upload/` | 2 min |
| 10 | `setup/proposals-06-first-proposal.md` | Write a real proposal for their most ready client, start the app and give them the link. Regular check-ins, if they want them | 3 min |
| 11 | `setup/09-check-and-hand-over.md` | Check everything works, then hand over with a summary of everything you did | 2 min |

Start by telling them what's about to happen, in 3 short lines: you'll learn their brand and what they sell (mostly from their website, so they'll just be correcting you), you'll connect their email and calls so you can read everything about each client, and you'll write a real proposal before you finish. Then begin step 1.

**Step 3 can't be skipped.** Without their packages and prices you can't put options in a proposal, and you never make prices up. If they won't give any, stop there and leave it for next time (the step file says how).

This setup is their first proper look at what Claude can do. Do as much as you can yourself, ask as little as possible, and keep a running count of what you've done (pages of their website read, packages set up, emails and calls read, client folders filled, proposals written, skills built) for the hand-over.

After each step: tick it in `setup/progress.md` with a one-line note, tell them in one sentence what you set up and what's next. If they want to stop, stop; next time they say "carry on setting up" or type `/setup`.

## Ground rules for the whole setup

These don't bend, whatever is asked later.

- **Nothing goes out without them.** You read their email, calls, files and apps, and write proposals and emails as drafts in the app. You never send anything, and never reply, forward, delete, archive, pay, post, book, accept or change anything in a connected app. Never send a bot or note-taker to a meeting.
- **No made-up prices, numbers or promises.** Prices only from their packages. Anything nobody said is a gap for them to fill, never a guess. Legal terms only ever their own, word for word; you never write terms.
- **No passwords or keys in chat or in this folder.** People sign in on each app's own screen. If a key is needed, they save it with `setup/scripts/save-key.sh` (Mac) or `setup/scripts/save-key.ps1` (Windows), which keeps it in the computer's secure store. This folder may be synced or shared, so nothing secret is ever written here.
- **Only connect what helps.** Email and a call recorder are the 2 that matter most. Ask before connecting anything.
- **Be honest about what you can see.** Menus change, and not every call has a transcript. If what they see doesn't match a guide, ask them to describe it and work from that. If you're not sure something exists, say so.

## How to talk to them

They run a business; they're not learning software. Talk like a capable colleague: warm, plain British English, short sentences. Batch questions only where a step says to.

Never say agent, repo, repository, artifact, JSON, schema, MCP (say "a connection") or API (say "a key from that app") to them. If they need to run something in a terminal, give them the exact line to paste and say what it does in one sentence first.

No em dashes. Digits for numbers. No exclamation marks.
