# Profile and Local Settings Domain

## Scope

This slice supports the single local user reaching a usable first-run experience quickly. It includes the profile fields and the smallest persistent settings needed by the existing foundation. Walking, permissions, maps, notifications, reminders, and Android lifecycle behavior are separate slices.

## Profile

The local profile contains:

- `displayName`: normalized non-empty Unicode text, 1–80 user-perceived grapheme clusters. The `characters` package is the implementation dependency; Dart UTF-16 code-unit length is not used.
- `heightCm`: integer centimetres, 80–250 inclusive.
- `weightKg`: decimal kilograms, 20.0–300.0 inclusive, precision 0.1 kg.
- `birthYear`: integer Gregorian year, 1900 through the current device year inclusive.

The domain stores canonical typed values, not raw form strings. Form input is normalized, parsed, and validated before persistence.

### Normalization and parsing

- Apply no NFC/NFKC transformation. Normalize only whitespace: trim leading/trailing Unicode White_Space characters and collapse consecutive Unicode White_Space characters to one ASCII space for display name.
- Preserve the user's letter case and Unicode characters.
- Empty or whitespace-only display name is invalid.
- Height and birth year accept ASCII decimal digits only, with optional surrounding whitespace and leading zeroes. Signs, exponent notation, grouping separators, and non-ASCII digits are rejected.
- Weight accepts ASCII digits with one optional `,` or `.` decimal separator, optional surrounding whitespace, and leading zeroes. Thousands separators, signs, exponent notation, multiple separators, and more than one fractional digit are rejected; input is never rounded and is stored at 0.1 kg precision.
- Invalid or ambiguous numeric input is rejected rather than guessed.

The application supplies the current Gregorian device year to the validator; the domain does not read the system clock. Tests inject a fixed year. If the device year is earlier than 1900, the profile form fails closed with a localized technical error rather than accepting an invalid range.

## Profile draft

A draft is a local, recoverable copy of partially entered profile fields.

- Do not persist an all-empty draft.
- Persist a draft after at least one meaningful field value exists.
- If the user clears every field, delete the draft.
- Draft values may be invalid or partial; they must never bypass final validation.
- Draft saves may be debounced, but the latest value must be flushed before leaving/backgrounding when practical through the repository boundary.
- When no profile exists, restore the draft into create mode.
- When a profile exists, use the saved profile as the base and overlay an existing draft for edit mode. A draft field has an explicit presence marker: absent means “unchanged”, while present with an empty value means “the user cleared this field”.
- Create abandon deletes the draft and leaves the app without a profile.
- Edit abandon deletes the draft and leaves the saved profile unchanged.
- Ask for confirmation only when abandoning would discard meaningful draft changes.

## Persistence consistency

Valid profile save upserts the one profile and deletes its draft in one Drift transaction. If persistence fails, the previous profile and draft remain available and the UI reports a localized save failure. The profile table uses a fixed singleton key/unique constraint so a second profile cannot be created by concurrent or repeated saves.

No profile or settings values are logged. Test fixtures use synthetic values only. Local databases and exports remain ignored by Git.

## Local application settings

Settings are separate from the profile aggregate and are singleton local state:

- `localeOverride`: Turkish, English, or system/default; unsupported system locales fall back to English.
- `themeMode`: system, light, or dark; default system.
- `weeklyActiveDayTarget`: integer 1–7 inclusive; default 3.

Reminder time and notification scheduling are intentionally not part of this slice or its UI. They will be designed together in a separate local-notification vertical slice.

## Observable acceptance criteria

1. Profile create and edit use the fields and ranges above.
2. Boundary values are accepted and immediately outside values are rejected.
3. Invalid submission changes neither the saved profile nor the draft.
4. Draft restoration works after a fresh database/repository instance.
5. Create and edit abandon semantics match this document.
6. Successful save leaves one valid profile and no draft.
7. Profile and settings survive application/repository reload independently.
8. Turkish and English labels/errors, light/dark/system themes, scalable text, narrow layout, 48dp targets, and non-color error semantics are covered by widget tests.
