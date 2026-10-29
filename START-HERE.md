# Start here

> **If you're a person reading this:** you don't need to do anything in this file. Open this folder in the Claude desktop app (the Code tab) and type **/setup** (or say "Read START-HERE.md and set me up"). Claude asks for your website, logo and colours, your packages and prices, and any proposal you'd like it to copy, connects your email, calendar and call recorder, then writes your first proposal from a real client. Most people are done in 30 to 40 minutes. The first time you open the folder, the app asks whether you trust it: choose **Yes, I trust this folder**. That lets Claude write your proposals and notes without asking every time; it still can't send or delete anything.

---

**Claude, this file is for you.** The person you work for has copied Proposal Writing OS onto their computer and wants it set up.

**If you've only just copied it for them** (you're running in a different folder, such as their home or Documents folder): setup must run from inside the Proposal Writing OS folder, because that's where your skills, permissions and their proposals live. Copy it as a plain folder, so it's theirs alone and not linked to the copy online. Use the line for their computer:
  - Mac: `D="$HOME/Documents/Proposal Writing OS"; mkdir -p "$D/setup/as-installed" && curl -fsSL -o "$D/setup/as-installed/proposal-writing-os.tar.gz" https://github.com/georgecairns-ui/proposal-writing-os/archive/refs/heads/main.tar.gz && tar -xzf "$D/setup/as-installed/proposal-writing-os.tar.gz" --strip-components 1 -C "$D"`
  - Windows (PowerShell): `$d = "$HOME\Documents\Proposal Writing OS"; New-Item -ItemType Directory -Force "$d\setup\as-installed" | Out-Null; curl.exe -fsSL -o "$d\setup\as-installed\proposal-writing-os.tar.gz" https://github.com/georgecairns-ui/proposal-writing-os/archive/refs/heads/main.tar.gz; if ($LASTEXITCODE -eq 0) { tar -xzf "$d\setup\as-installed\proposal-writing-os.tar.gz" --strip-components 1 -C "$d" }`

  If the download fails, check their internet connection and run the line again. Don't try another way in.

  The download is kept in `setup/as-installed/` on purpose: it is what lets you bring this folder up to date later, without losing anything of theirs (the `get-updates` skill).

  If you've already copied it another way (for example with `git clone`, or into a different folder), that's fine: use that folder. Then give them the steps to open it: in the Claude desktop app, open the Code tab, choose that folder, pick "Yes, I trust this folder", then type `/setup`. Stop there; don't start the setup from the wrong folder. Follow this file, then the step files in `setup/`, in order.

## What Proposal Writing OS is

Proposals that write themselves, in the business's own brand, run by you, with an app on top.

- **One folder per client.** Everything about a client lives in their own folder (`files/02-clients/<client>/`): call notes, transcripts, emails, their brief, anything. The person drops things in; you keep each folder complete by saving in summaries of the client's emails and calls.
- **One click.** On the app's Clients page they press **Write proposal** (or **New proposal**, and paste a few lines). You read everything about that client and write the whole proposal. New client folders get a proposal by themselves if they want that.
- **Every proposal tells the same story**: who the client is, what's hurting them (in their own words), how the business will fix it, how it'll be delivered, the options with one recommended, and the next steps to get started. A cover, a short opening note and a contents page come first.
- **In their brand.** Their logo, colours and fonts, from their website or brand guidelines. If they have a proposal template, you copy its order, headings and wording.
- **Their prices, never guesses.** Their packages and prices are saved once; the app works out every option's price, VAT and total. Anything a client wants that isn't priced is flagged for them.
- **Their own proposal skill.** Setup ends by building a skill named after their business that holds all of this, so every proposal comes out the way they'd write it, here and in Claude everywhere else.
- They check it in the **app** at **http://localhost:4747**, change any words by clicking on them, ask you to change anything else, approve it, save it as an A4 PDF and send it themselves. You write a follow-up when a sent proposal goes quiet.
- If they'd like it, you **check in a few times a day** on your own, at times they choose, so new client folders, emails and calls are picked up and proposals keep moving. They can skip it.

This folder is their workspace from now on: `context/` holds what you know about the business (`context/sales.md` is what they sell, and `context/proposals.md` how they write proposals and start with new clients), `files/` their documents (with a folder per client in `files/02-clients/`), `.claude/skills/` your saved know-how (they work as commands like `/write-a-proposal`), and `skills-to-upload/` the skills you build for them, packed up for them to add to Claude.

## Before you begin

1. **Check you're in the Claude desktop app.** Connector tools are often deferred, so they may not be in your visible tool list until you load them. First search your tools for `session_connectors_status` (for example with your tool search), then call it. If you can't find it, or the call fails, you're not in the desktop app's Code tab, and you can't check or switch on their connections. Then stop and say, in your own words: "Setup needs the Claude desktop app. Open it, choose the Code tab, pick this folder and type /setup." Do nothing else.
2. **Ask how much they've used Claude Code,** but only when it's needed. One question, on its own. Read `setup/progress.md` first. If it says setup is complete, skip the question. If it has `Guide mode: beginner`, `Guide mode: some` or `Guide mode: confident`, use that. If it says `Guide mode: not asked yet`, ask: "Before we start: how much have you used Claude Code? 1. Never 2. A few times 3. Most days." Write the answer in `setup/progress.md` in place of `not asked yet`, as `Guide mode: beginner`, `Guide mode: some` or `Guide mode: confident`, and guide them that way for the whole setup:

   | Guide mode | How you guide |
   |---|---|
   | beginner | One step per message. Say where every button is on their screen ("top left", "the + under the message box"). Plain words only: "connection", never MCP, API, JSON or repo. Check each thing worked before the next, and say what you just did |
   | some | 2 or 3 steps per message, and a check after each connection |
   | confident | Batch it, email and calendar first, then the rest: "Connect your email and calendar, then your call recorder, in Connectors, and tell me when they're done", then check them all at once |

   The guide mode changes the pace and how much you explain. It never changes the rules: every connection is proven with a real read, and email and calendar come before anything else.
3. Read `setup/progress.md`. If some steps are ticked, say hello, remind them where you got to, and carry on from the first unticked step.
4. Read `CLAUDE.md` in this folder: the standing rules.
5. If setup is already complete, don't run it again. Ask what they'd like to do.

## The steps

| Step | File | What happens | Their time |
|---|---|---|---|
| 1 | `setup/01-quick-questions.md` | One message of quick questions: their website, logo and colours, email, call recorder, any proposal templates, where client files live | 2 min |
| 2 | `setup/proposals-01-your-brand.md` | You learn their brand from their website and logo and put it on the app and every proposal. They say yes or tweak it | 2 min |
| 3 | `setup/proposals-02-what-you-sell.md` | **Required.** Their packages and prices, VAT, payment terms, how they deliver and what happens when someone says yes. You draft it all from their website first; they correct it | 5 min |
| 4 | `setup/proposals-03-your-templates.md` | Import any proposal or template they'd like you to copy | 2 min |
| 5 | `setup/02-connect-email-and-calendar.md` | Connect email and calendar, prove both, and read the last 30 days to find their clients and the proposals they've sent | 5 to 10 min |
| 6 | `setup/03-connect-call-recordings.md` | Connect their call recorder, if they have one | 2 min |
| 7 | `setup/05-get-to-know-the-business.md` | Fill in the rest of your notes and learn how they write | 3 min |
| 8 | `setup/proposals-04-your-client-folders.md` | Set up a folder per client from the clients found in step 5, and fill each from their email, calls and files (connecting their files app if client files live in the cloud) | 2 min |
| 9 | `setup/proposals-05-your-proposal-skill.md` | Build their own proposal skill, saved here and packed in `skills-to-upload/` | 2 min |
| 10 | `setup/proposals-06-first-proposal.md` | Write a real proposal for their most ready client, start the app and give them the link | 3 min |
| 11 | `setup/08-make-it-automatic.md` | You agree the check-in times (or they skip it), Claude lets check-ins read without stopping, creates the check-in and proves it runs | 2 min |
| 12 | `setup/09-check-and-hand-over.md` | Check everything works, then hand over with a summary of everything you did | 2 min |

Start by telling them what's about to happen, in 3 short lines: you'll learn their brand and what they sell (mostly from their website, so they'll just be correcting you), you'll connect their email and calls so you can read everything about each client, and you'll write a real proposal before you finish. Then begin step 1.

**Step 3 can't be skipped.** Without their packages and prices you can't put options in a proposal, and you never make prices up. If they won't give any, stop there and leave it for next time (the step file says how).

This setup is their first proper look at what Claude can do. Do as much as you can yourself, ask as little as possible, and keep a running count of what you've done (pages of their website read, packages set up, emails and calls read, client folders filled, proposals written, skills built) for the hand-over.

After each step: tick it in `setup/progress.md` with a one-line note, tell them in one sentence what you set up and what's next. If they want to stop, stop; next time they say "carry on setting up" or type `/setup`.

## Ground rules for the whole setup

These don't bend, whatever is asked later.

- **Nothing goes out without them.** You read their email, calls, files and apps, and write proposals and emails as drafts in the app. You never send anything, and never reply, forward, delete, archive, pay, post, book, accept or change anything in a connected app. Never send a bot or note-taker to a meeting.
- **No made-up prices, numbers or promises.** Prices only from their packages. Anything nobody said is a gap for them to fill, never a guess. Legal terms only ever their own, word for word; you never write terms.
- **No passwords or keys in chat or in this folder.** People sign in on each app's own screen, through Claude's Connectors. Setup never uses keys. (The one optional extra that does, Xero draft invoices, has its own guide, `setup/connections/xero-drafts.md`, which comes with Money View OS and the Small Business Toolkit. It is only offered when they ask for it; if that file isn't in this folder, tell them it comes with Money View OS.)
- **Only connect what helps.** Email and a call recorder are the 2 that matter most. Ask before connecting anything.
- **Be honest about what you can reach.** Check the connection status yourself rather than asking what's on their screen, and prove every connection with a real read before you rely on it. Not every call has a transcript. If you're not sure a connector exists, search Claude's connector directory and say what you found.

## How to talk to them

They run a business; they're not learning software. Talk like a capable colleague: warm, plain British English, short sentences. Batch questions only where a step says to.

Never say agent, repo, repository, artifact, JSON, schema, MCP (say "a connection") or API to them. If a step needs a command run, run it yourself and tell them in one sentence what it does.

No em dashes. Digits for numbers. No exclamation marks.
