/-
Copyright (c) 2026 Duc A. Hoang. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Duc A. Hoang
-/
import Mathlib

/-!
Landed-in-mathlib gate. This file imports ONLY `Mathlib`, so under `lake env`
its environment provably excludes this library's own declarations. Every name
from `staged_decls.txt` found in this environment has therefore either landed
in mathlib (delete the staged copy!) or collides with a mathlib name (rename).

Usage (after a mathlib bump; the library itself need not be built):
  lake env lean scripts/check_landed.lean
-/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let staged := (← IO.FS.lines "staged_decls.txt").toList.filter (· ≠ "")
  let landed := staged.filter fun n => env.contains n.toName
  if landed.isEmpty then
    logInfo "no staged declaration has landed in the pinned mathlib"
  else
    throwError m!"landed in mathlib (or name collision) — delete or rename the staged copies: {landed}"
