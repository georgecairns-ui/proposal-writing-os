# Step 6: connect call recordings

Goal: if they record calls, you can read the transcripts. Calls are where clients say what's really hurting, in their own words, and those words make the best proposals.

Be honest about what each one gives. Microsoft Teams, Zoom and Google Meet only make a transcript when recording or transcription is switched on for that meeting (and on some plans not at all). A note-taker such as Fathom, Fireflies or Granola is the easiest way to have every call written up.

If they said in step 1 that they don't record calls, say one sentence ("No problem. After a call, drop your notes into the client's folder, even 3 rough lines, or press Brain dump in the app and talk. If you ever start recording calls, with Fathom or Fireflies for example, I'll read them by myself") and move on to the next step.

## 6.1 Connect their recorder

| They use | Follow |
|---|---|
| Fathom | `setup/connections/fathom.md` |
| Fireflies | `setup/connections/fireflies.md` |
| Otter | `setup/connections/otter.md` |
| Granola | `setup/connections/granola.md` |
| tl;dv | `setup/connections/tldv.md` |
| Read AI | `setup/connections/read-ai.md` |
| Zoom | `setup/connections/zoom.md` |
| Microsoft Teams | `setup/connections/microsoft-365.md` |
| Google Meet | `setup/connections/google-drive.md` |
| Something else | Ask whether it emails a summary after each call. If it does, you'll read those through their email (step 5). Otherwise they save transcripts into the client's folder. |

Most recorders have a Claude connector: the person signs in, approves, done. Only use an API key if the guide says the connector isn't available on their plan.

## 6.2 Check it works

Read the list of their 3 most recent calls (titles and dates only) and tell them:

> I can see your calls. The latest was "Discovery call with Hollins Lettings" yesterday. When I set up your client folders I'll save a write-up of each client's calls into their folder.

## 6.3 Record it

Add the row to `context/tools.md` with "Read transcripts and summaries" and "Never send a bot to a meeting, share a recording or invite anyone". Tick step 6 in `setup/progress.md`.
