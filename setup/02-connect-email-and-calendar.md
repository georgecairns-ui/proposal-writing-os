# Step 5: connect email and calendar

Goal: you can read their email and calendar, proven with a real read, and you've read the last 30 days. That's how you see what each client asked for and **confirmed in writing** (budget, scope, dates, who decides), spot new requests for a proposal or a quote, and find the clients they're talking to and the proposals they've already sent. The calendar shows which clients they're meeting. Setup doesn't go past this step until it's done.

## 5.1 One sentence on why

> This is the big one. Clients confirm the important things by email, so when I write a proposal I'll read your emails with that client and use exactly what they agreed. I never send, reply to or delete anything.

## 5.2 Connect, and check for yourself

Find their provider's guide:

| They use | Guide |
|---|---|
| Gmail or Google Workspace, Google Calendar | `setup/connections/gmail-and-google-calendar.md` |
| Outlook or Microsoft 365 with a work account | `setup/connections/microsoft-365.md` |
| Outlook.com, Hotmail, iCloud, Yahoo or another provider | There's no Claude connector for it. Go to 5.5 |

Email and calendar can come from different providers (for example iCloud mail with Google Calendar). Find the guide for each half separately. A half with no connector goes to 5.5; the other half still goes through 5.2 and 5.3 and must be proven.

Then look up this session's connections (`session_connectors_status`) and act on what you find, for the email connector and the calendar connector separately:

| What you find | What you do |
|---|---|
| It's there and on | Go to 5.3 |
| It's there but switched off for this session | Switch it on (`set_session_connector_enabled`). They'll be asked to approve: tell them that's expected. It works from your next message, so end this message by saying you've switched it on and will check it next |
| It isn't there | Give them the path from the guide, in their guide mode: in the Claude desktop app, Customize, then Connectors, then the app's name, then Connect, then sign in on Google's or Microsoft's own page and approve. Ask them to tell you when it's done, then look again |
| It needs signing in (`needs_auth`) | Tell them the one thing to do: open Connectors (or type `/mcp` in this chat), choose it and sign in. Then look again |
| It's not working (`failed`) | Reconnect it (`reconnect_session_connector`). It's ready from your next message; end this one by saying so, then look again |

Keep going round this table until both are on. Never ask for their email password: they sign in on Google's or Microsoft's own screen.

## 5.3 Prove it

With their permission, read the subjects and senders of the 5 most recent emails and today's calendar, and say what you see in one line, without quoting anything private:

> I can see your inbox (last email from Dev at Hollins Lettings, 20 minutes ago) and 3 things in your calendar today.

If the read fails, look up the connection status again and go back to 5.2. A connection only counts once a read has worked.

## 5.4 Read the last 30 days

Tell them first: "I'll now read the last 30 days of your email, to find the clients you're talking to and the proposals you've already sent. On a busy inbox this takes a few minutes. I'll keep you posted."

1. List every thread from the last 30 days, sent and received, by sender and subject only.
2. Leave out newsletters, receipts, automatic notifications and no-reply senders.
3. Open only the threads from real people, in batches. After each batch, one progress line: "Read 140 of 380 conversations, 6 clients so far."
4. **Clients and prospects:** anyone they're quoting, scoping or discussing work with, the same people step 8 sets up a folder for (`setup/proposals-04-your-client-folders.md`). For each one, save a short summary as `files/02-clients/_found-in-email/<Client Name>.md`, in the form step 8 uses for `Emails with <name>.md`: who they are, the contact (name, role, email), what they asked for, and what they **confirmed in writing** (budget, scope, dates, who decides) at the top, with their exact words where they matter. If that file already exists (a resumed setup), add to it instead of overwriting it: keep what is there and add what's new. Never whole threads. The folder starts with `_`, so the app doesn't treat it as a client; step 8 moves each summary into the right client's folder.
5. **Proposals already sent:** in their sent email, a proposal or quote they sent a client (an attachment with "proposal" or "quote" in its name, or an email that sets out options and prices). Add it to that client's summary: the date sent, the file name, what it offered and the prices as written, and whether the client has replied since. Don't add it to the app: it isn't one of the proposals you wrote.
6. Calendar: don't copy any events (Proposal Writing OS has no calendar). Read the last 30 days of the calendar only to learn who they meet and what's recurring: add "met on <date>" to the summary of any client they met, and note their usual working days and hours in `context/routines.md`.

Keep the counts for the hand-over (emails read, clients found, proposals already sent). Nothing is sent, labelled, archived or marked as read.

## 5.5 The only ways past this step

- **Proven:** 5.3 worked for email and calendar, and 5.4 (the 30-day read) is done. Record them (5.6) and go on.
- **No Claude connector for their provider** (Outlook.com, Hotmail, iCloud, Yahoo, a hosting company's email). Say plainly: "There's no Claude connector for [provider], so I can't connect to your email live." Offer the one alternative: forward work email to a Gmail account and connect that. Record it as `no-connector` (5.6) and go on. Proposals still work from what's in each client's folder.
  This exit covers only the half that has no connector. If their email has no connector but their calendar does (or the other way round), the other half still goes through 5.2 and 5.3, must be proven, and gets its part of 5.4.

If they don't want to connect email, say in one line what won't work without it ("I won't be able to read what your clients asked for and confirmed in writing, or find the clients and proposals already in your email"), and ask once if they'd like to go ahead. If they still say no, stop setup here, note it in `setup/progress.md`, and tell them they can type `/setup` whenever they're ready. Don't go on to step 6 without email.

If they're waiting on someone else first (for example their IT administrator has to approve the connector, or they need a password reset), stop in the same way: note it in `setup/progress.md` and tell them to type `/setup` when it's sorted. Don't go on to step 6.

## 5.6 Record it

In `apps/home/data/connections.json` (format: `setup/connections/README.md`, "Recording a connection"): `"status": "connected"` and today's date in `checked` for each one proven, or `no-connector`. Email and calendar from the same provider share 1 row, keyed `gmail-and-google-calendar` or `microsoft-365`, the same row step 1 started. From different providers, each has its own row: a no-connector email row is keyed by the provider's name in lower case with hyphens (for example `icloud-mail`), and a proven calendar keeps its guide's key (`gmail-and-google-calendar` or `microsoft-365`). The same goes the other way round. When email and calendar come from the same provider and neither has a Claude connector (for example iCloud), they share 1 row keyed by the provider's name, for example `icloud`.

In `context/tools.md` ("Connected apps"): app, how connected, today's date, "Read; save summaries into client folders", and "Never send, reply, forward, delete, archive, label or unsubscribe". Tick step 5 in `setup/progress.md`.

## Rules for their inbox, from now on

- Read only what a proposal needs: emails with that client. Don't read more than you need.
- Never send, reply, forward, delete, archive, label, mark as read, unsubscribe or accept an invite, even though the connection technically allows some of these.
- The covering email and follow-ups live on the proposal in the app; the person opens them in their email and sends them. Save a draft into their mailbox only if they ask for that specific email.
- Don't copy whole private emails into this folder. A short summary with the key facts and exact words that matter, in the client's folder, is enough.
