# HoangMathLib

[![CI](https://github.com/hoanganhduc/HoangMathLib/actions/workflows/ci.yml/badge.svg)](https://github.com/hoanganhduc/HoangMathLib/actions/workflows/ci.yml)

A [mathlib](https://github.com/leanprover-community/mathlib4)-style staging
library for [Lean 4](https://lean-lang.org/) formalizations in graph theory and
combinatorial reconfiguration, by [Duc A. Hoang](https://hoanganhduc.github.io/).
Results that are general enough for mathlib are staged here, upstreamed, and
then deleted; research code in progress lives alongside them.

- Upstreaming dashboard: <https://hoanganhduc.github.io/HoangMathLib/upstreaming/>
  (API docs via doc-gen4 may be added later)

## Layout and lifecycle

Following the community satellite-library convention
(as in [cam-combi](https://github.com/YaelDillies/LeanCamCombi),
[PFR](https://github.com/teorth/pfr), [FLT](https://github.com/ImperialCollegeLondon/FLT)):

| Where | What |
|---|---|
| `HoangMathLib/Mathlib/A/B/C.lean` | **Staging**: lemmas destined for mathlib's `Mathlib/A/B/C.lean`, written in mathlib's namespaces with mathlib's conventions, `sorry`-free. |
| `HoangMathLib/Reconfig/`, … | **Research**: paper-driven work in progress; `sorry` allowed. |

Lifecycle of a staged lemma: research → generalized into the staging mirror →
flagged "ready to upstream" by the
[dashboard](https://hoanganhduc.github.io/HoangMathLib/upstreaming) → ported to
current mathlib master and PRed (import rewrite `HoangMathLib.Mathlib.X → Mathlib.X`,
header form, deprecations) → after the PR lands and this library bumps past it,
**the staged copy is deleted**.

Import discipline (CI-enforced):

- staged files import only `Mathlib.*` and staged siblings — never research files;
- no bare `import Mathlib` anywhere in the library tree (`scripts/` excepted —
  `check_landed.lean` relies on it by design);
- the staging tree is `sorry`-free.

## Using this library

```toml
[[require]]
name = "hoangmathlib"
git = "https://github.com/hoanganhduc/HoangMathLib.git"
rev = "<commit-sha-or-tag>"
```

Pin by **commit SHA** for reproducibility (git tags here track Lean toolchain
versions, not content milestones). Toolchain: this library always matches the
`lean-toolchain` of its pinned mathlib stable release.

To build locally:

```bash
lake exe cache get
lake build
```

## Versioning and updates

- mathlib is pinned to a **stable release tag** and bumped along the
  stable-tag ladder by a weekly
  [mathlib-update-action](https://github.com/leanprover-community/mathlib-update-action) run.
- A weekly [master probe](.github/workflows/mathlib-master-probe.yml) builds
  the staging subtree against mathlib master, so upstreaming friction is
  discovered continuously rather than at PR time.

## Community checklist (upstreaming hygiene)

- Small additions to existing mathlib files: PR directly. New theory: open a
  [Zulip](https://leanprover.zulipchat.com/) thread first.
- Follow mathlib PR conventions: title format `feat(Combinatorics/X): ...`,
  Apache-2.0 header with `Authors:` line, module docstring, 100-char lines.
- Disclose AI assistance in PR descriptions per the
  [mathlib AI policy](https://leanprover-community.github.io/contribute/index.html).
- Cite this library by commit SHA (and tag where one exists).

## License

Apache License 2.0 — the same license as mathlib, so staged files can move
there without relicensing. See [LICENSE](LICENSE).
