# Contributing

This is primarily a personal staging library, but issues and PRs are welcome.

- Staged files (`HoangMathLib/Mathlib/**`) follow the
  [mathlib style guide](https://leanprover-community.github.io/contribute/style.html)
  exactly: Apache-2.0 copyright header, module docstring, docstrings on
  definitions, 100-character lines, mathlib naming conventions, and the file
  form (`module` + `public import`) of the pinned mathlib version.
- Staged files import only `Mathlib.*` and staged siblings, and are
  `sorry`-free (CI enforces both).
- Research files are freeform; put new material there first.
- Every new `.lean` file must be imported from `HoangMathLib.lean`.

If a staged lemma you need has already landed in mathlib, please open an issue
so the staged copy can be deleted.
