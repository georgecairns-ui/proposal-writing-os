# Proposal Writing OS

**Put everything about a client in one folder. Get a proposal in your brand.** A free kit from [Get AI Powers](https://getaipowers.com), run by Claude.

You drop a client's call notes, emails and brief into their folder and press **Write proposal**. Claude reads all of it, plus your emails and call recordings with them, and writes the whole proposal: who they are, what's hurting them in their own words, how you'll fix it, how you'll deliver it, your options with one recommended, and the next steps to get started. It's laid out in your logo, colours and fonts, with your own packages and prices, ready to check, change and save as a PDF.

Nothing goes out without you. Claude writes; you approve it, save the PDF and send it yourself.

**See it first:** [a clickable demo with a made-up business](https://claude.ai/artifact/MQUm4uP9YM8PNCh4sPmhs7), opening on a finished proposal.

Proposal Writing OS is part of a toolkit of 7 free tools from Get AI Powers. The others (a task list, a pipeline, content, money and more) show in the app's menu, and Get AI Powers sets them up with you on a free call.

## What happens when you type /setup

You copy the kit, open it in Claude Code and type **/setup**. In about 20 minutes, Claude:

- **Learns your brand.** From your website, your logo and any brand guidelines: your colours, fonts and logo go on every proposal, and on the app.
- **Learns what you sell.** Your packages and prices, VAT, payment terms, how you deliver and what happens when someone says yes. It drafts all of it from your website first, so you mostly just correct it.
- **Copies your template.** Got a proposal you're proud of? Drop it in. Claude copies its order, headings and wording.
- **Connects your email and call recorder,** so it can read what each client asked for, what's hurting them and what they confirmed in writing.
- **Sets up a folder for each client** and fills it from your emails and calls.
- **Builds your own proposal skill,** named after your business, saved in the **skills-to-upload** folder so you can add it to Claude and write proposals your way everywhere, including on your phone.
- **Writes your first proposal** for a real client, before setup ends.

## What it does

- **One folder per client, one click.** Everything about a client goes in their folder. On the **Clients** page, press **Write proposal**. New client folders can get a proposal by themselves.
- **The same strong story every time.** A cover, a short opening note, a contents page, then: about them, what's getting in the way, how you'll fix it, how you'll deliver it, your options, and next steps. Rename, reorder or switch off any section.
- **Their pain, in their words.** Claude uses the exact things clients said on calls and in emails, so the proposal reads like you really listened.
- **Your prices, never guesses.** Options come from your saved packages; the app works out every price, VAT and total. Anything a client wants that isn't on your price list is flagged for you to price. Anything nobody said is listed for you to fill in.
- **One recommended option,** with the reason it's right for them.
- **Change anything.** Click any words on the page and type. Or ask Claude: "make it shorter", "lead with the cheaper option".
- **Save as PDF** in clean A4 pages, and open the covering email Claude wrote, ready to attach and send.
- **Follow-ups.** When a sent proposal goes quiet, Claude writes a friendly nudge with a real reason to reply.
- **Your numbers.** What's out with clients, won this month and your win rate, all worked out from your proposals.
- **Brain dump.** Press **Brain dump** on any page and talk: "Hollins want it live before Christmas, and do a proposal for the florist I met." Claude files it in the right folder and gets on with it.

## What you need

- **Claude Code**, signed in with a paid Claude plan (Pro or Max). Your email and call recorder connections come from your Claude account, and Claude Code only uses them when it's signed in with a subscription. The Claude desktop app works too.
- Nothing else to install in most cases. The app runs on your own computer using Node (Claude installs it for you if it's missing, with your permission).
- Google Chrome or Microsoft Edge for saving proposals as PDFs (any modern browser shows them).
- About 20 minutes, once.

## Get started

1. **Open Claude Code** in the Claude desktop app (the Code tab) or in the Terminal (on Windows, PowerShell). Any folder will do for this first step.
2. **Ask Claude to fetch the kit.** Paste this:
   > Copy https://github.com/georgecairns-ui/proposal-writing-os into a folder called "Proposal Writing OS" in my Documents, then tell me how to open it and set it up.

   Claude copies everything onto your computer and gives you one line to open the new folder. In the desktop app, you choose the folder instead. (If your computer asks to install "command line developer tools" or Git, say yes; it's free and takes a few minutes.)
3. **Open the Proposal Writing OS folder in Claude Code and choose "Yes, I trust this folder".** The first time, Claude Code asks whether you trust the folder and warns that it pre-approves some permissions. Those permissions only let Claude write your proposals, your business notes and your client folders, read web pages and start the app, without stopping to ask each time. It still can't send, delete or change anything in your email or other apps. Press the down arrow, then Enter.
4. **Type `/setup`.**

Then it opens your proposals and gives you the link, **http://localhost:4747**. Bookmark it.

## Every day

| Do or say | What happens |
|---|---|
| Drop notes, a transcript or an email into a client's folder, then press **Write proposal** | The whole proposal, in your brand, in a few minutes |
| **New proposal**, then type a name and paste a few lines | Claude makes the client's folder and writes it |
| "Make it shorter", "lead with the Growth package" (or **Ask Claude** on the proposal) | Just that change, nothing else touched |
| "Chase Marlow" | A friendly follow-up, ready to open and send |
| "Rebuild my proposal skill" | Your own skill brought up to date with your latest packages and wording |

## Your information

Your proposals, packages and client folders live in this folder on your computer. Claude reads your email and call recordings through the connections you approve, and saves short summaries into each client's folder. It never sends, deletes, pays or posts anything for you, and never sends a bot to your meetings. There's no Proposal Writing OS account or server; Get AI Powers can't see any of it. Read [docs/PRIVACY-AND-SAFETY.md](docs/PRIVACY-AND-SAFETY.md) for the detail.

## Make it yours

Your colours and fonts, your cover, your section names, your packages, your template. Ask Claude, or use Preferences and Packages in the app. See [docs/CUSTOMISING.md](docs/CUSTOMISING.md).

## Want it set up properly for you?

Proposal Writing OS works on its own. If you'd like help building your folders, business context and Claude skills around how you really sell, Get AI Powers can help. Find us at [getaipowers.com](https://getaipowers.com).

## What's inside

```
START-HERE.md          Claude reads this first and runs setup (/setup)
toolkit.json           what this tool is, for attaching it to the others in the toolkit
ATTACHING.md           how the toolkit's tools attach to each other
CLAUDE.md              Claude's standing instructions in this folder
Open Proposals.html    double-click to open your proposals (or use the link Claude gives you)
setup/                 the 11 setup steps, a guide per app in connections/, and the key scripts
context/               Claude's notes about your business; proposals.md is how you write proposals
.claude/skills/        saved know-how; each one also works as a command in Claude Code
skills-to-upload/      the skills Claude builds for your business, packed up to add to Claude
files/                 your documents, with a folder per client in files/02-clients
apps/                  the proposals app, its look (theme.css) and your proposals' look (proposals/brand/brand.css)
docs/                  customising, privacy and safety
maintainers/           for people developing Proposal Writing OS itself
```

## Licence

Free to use and change for your own business. Not for resale. See [LICENSE](LICENSE) for the plain-English terms.

Fonts: Figtree (the app's font) and Source Serif 4 (proposal headings), plus Zilla Slab, all under the SIL Open Font License (see `apps/shared/fonts/OFL.txt`).
