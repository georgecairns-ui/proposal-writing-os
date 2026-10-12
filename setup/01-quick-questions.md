# Step 1: quick questions

Goal: in one short exchange, learn what the person uses and has, so every later step works from their own things and asks nothing twice.

## 1.1 Check what you can reach (quietly, before asking anything)

1. **This folder.** Read `setup/progress.md`, write a test line to its "Notes for next time" section, read it back and remove it. If you can't, stop and ask them to open this folder in Claude Code (`cd` into it and run `claude`), or give the Claude app access to it.
2. **Your connections.** List the tools you have right now. In Claude Code, the person can type `/mcp` to see them. Note any for email, calendar, call recording and files (Google Drive, OneDrive, Dropbox). Connectors added to their Claude account appear automatically in Claude Code when it's signed in with a Claude subscription.
3. **Can you read web pages?** Check you have web search or web fetch. You'll use it to learn their brand and packages from their website.
4. **Where the folder lives.** From its path: Downloads or Desktop (suggest moving it to Documents first, because the app remembers the location), a cloud-synced folder (fine, it's backed up), or a folder shared with other people (point out that anyone with access can read their proposals).
5. **Their computer.** Mac or Windows, from the path or by running a harmless command.

## 1.2 Ask everything in one message

Open with what you found in 1.1, so they see you've already looked: "You've already got Gmail and Fathom connected to Claude, so I'll use those." Then send the questions as one friendly, numbered message. Skip anything you already know and say so. Tell them short answers are fine, and that they can drop files straight into the chat.

> To set this up properly I need a few things. Short answers are fine, and you can drop files straight in here.
>
> 1. Your first name, your business's name, and **your website**. I'll learn your brand and what you sell from it, so you'll mostly just be correcting me.
> 2. **Your logo.** Drop the file in here (a PNG or SVG is best), or tell me where it is. If you have a version for dark backgrounds, that too.
> 3. **Your brand colours**, if you know them (or brand guidelines, if you have them). If not, I'll take them from your website.
> 4. **Proposal templates.** Have you got a proposal you're proud of, or a template you always use? Drop 1 to 3 in here (Word, PDF, Google Docs or Canva). I'll copy the layout and wording. If not, no problem.
> 5. Which **email** do you use for work? (Gmail or Google Workspace, Outlook with a work Microsoft account, Outlook.com, or something else.) Clients often confirm the important things by email, such as budget, scope and dates, so I'll read your emails with each client when I write their proposal.
> 6. Do you **record your calls** with clients? If so, with what? (For example Fathom, Fireflies, Otter, Granola, tl;dv, Read AI, Zoom, Microsoft Teams or Google Meet.) Calls are where clients tell you what's really hurting, in their own words.
> 7. **Where do you keep things about each client** today? (A folder per client on your computer, Google Drive, OneDrive, Dropbox, your email, nowhere in particular.)
> 8. Would you like me to check for new client folders and emails **automatically** while you work, and write proposals for new clients as they come in? (It uses a little of your Claude allowance and needs the Claude app open on your computer.)

## 1.3 Write it down

- `context/tools.md`: "Your setup" (computer, Claude version, workspace location, email provider, solo or team) and "Connected apps" (one row per app they named, with "How it's connected" left as "to do"). Their answers to questions 7 and 8 under "Notes".
- `context/business.md`: business name and website.
- `apps/proposals/data/proposals.json` (save safely): `settings.yourName`, `settings.businessName`, `settings.brand.website`, and `settings.emailProvider` (`gmail`, `outlook-work`, `outlook-personal` or `other`), so the app's email buttons open the right place.
- Any files they dropped in: logo and brand guidelines into `files/04-marketing/brand/`, proposal templates into `files/03-sales/proposals/templates/`. Make the folders if needed. Don't open the templates yet (step 4 does).

Tick step 1 in `setup/progress.md`.

## What to say

> Thanks Sam. I've got your website, your logo and 2 old proposals. Gmail for email and Fathom for calls, and your client files are in Google Drive. Next I'll read your website and put your brand on the app and your proposals.
