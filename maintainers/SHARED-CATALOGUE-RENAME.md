# Proposed shared change: the catalogue's proposals entry

Proposal Writing OS was planned as "Proposal Writer OS" in the repository `proposal-writer-os`. George named it Proposal OS on 12 October 2026, then chose the repository name **`proposal-writing-os`** and renamed the app **Proposal Writing OS** on 21 October. Every tool's `apps/shared/catalogue.json` has an entry for it, and that entry is what the locked menu item and the attach instructions use.

## What changed here

`apps/shared/catalogue.json`, the entry with `"id": "proposals"` only:

```json
{
  "id": "proposals",
  "name": "Proposal Writing OS",
  "description": "Put everything about a client in one folder and get a proposal in your brand. Claude writes it with your packages and prices, and you check it before it goes anywhere.",
  "icon": "fileText",
  "app": "apps/proposals/",
  "repository": "proposal-writing-os"
}
```

The tool id (`proposals`) and app folder (`apps/proposals/`) are unchanged, so nothing that attaches by id breaks.

## What still needs doing, in the other tools

1. **Task List OS and Pipeline OS**: the same change to their `apps/shared/catalogue.json`, by pull request in each. Until then, their locked "Proposal Writer OS" menu item shows the old name and description, and attaching from them would look for `proposal-writer-os`, which doesn't exist.
2. **`ATTACHING.md`** (identical in every tool): the toolkit table's row becomes `proposal-writing-os` | Proposal Writing OS | `apps/proposals/` | "Put everything about a client in one folder, get a proposal in your brand". It changes in every tool at once, so it's unchanged here for now.
3. **`TOOLKIT.md`** in the Drive toolkit folder: the same row.

`VERSION` stays 6: no shared code changes.

## Done, 21 October 2026

The menu entry and the `ATTACHING.md` rows above are now the same in every toolkit repository (Task List OS, Pipeline OS, Skill and Folder Map OS, Proposal Writing OS and Content Machine OS), by a pull request in each, together with the Skill and Folder Map OS entry, which was also out of date in some of them.
