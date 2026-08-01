/-
Copyright (c) 2026 Duc A. Hoang. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Duc A. Hoang
-/
import Lean

/-!
Emit the names of all declarations whose defining module lies under the module
prefix given as the first argument (default `HoangMathLib.Mathlib`), one per
line. Used to generate `staged_decls.txt` for `check_landed.lean`.

Usage (library must be built first):
  lake build
  lake env lean --run scripts/list_decls.lean HoangMathLib.Mathlib > staged_decls.txt
-/

open Lean

unsafe def main (args : List String) : IO Unit := do
  initSearchPath (← findSysroot)
  enableInitializersExecution
  let root := (args.headD "HoangMathLib.Mathlib").toName
  -- Import the library root so the staged modules are in the environment.
  let env ← importModules #[{module := `HoangMathLib}] {}
  let mods := env.allImportedModuleNames
  env.constants.forM fun n _ => do
    if !n.isInternal then
      if let some idx := env.getModuleIdxFor? n then
        if root.isPrefixOf mods[idx.toNat]! then
          IO.println n
