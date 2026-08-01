/-
Copyright (c) 2026 Duc A. Hoang. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Duc A. Hoang
-/
import HoangMathLib.Mathlib.Combinatorics.SimpleGraph.Clique

/-!
# Combinatorial reconfiguration: basic definitions

Research area for combinatorial reconfiguration of independent sets
(token sliding, token jumping, token addition/removal). Work here is in
progress and may carry `sorry`; anything that stabilises and generalises
moves to `HoangMathLib/Mathlib/` for upstreaming.

## Main statements

* `SimpleGraph.IsIndepSet.tj_step`: legality of a token-jumping move —
  replacing the token on `v` by one on a vertex `w` with no neighbour among
  the remaining tokens keeps the token set independent.
-/

namespace SimpleGraph

variable {α : Type*} {G : SimpleGraph α} {s : Set α} {v w : α}

/-- Token-jumping legality: moving a token from `v` to a vertex `w` that has
no neighbour among the remaining tokens keeps the token set independent.

The hypotheses are deliberately weaker than the informal move description:
`v ∈ s` is not needed (if `v ∉ s` this is a token-addition move), and
`w ∉ s` is not needed (re-inserting an existing token changes nothing). -/
theorem IsIndepSet.tj_step (hs : G.IsIndepSet s)
    (hw : ∀ u ∈ s \ {v}, ¬G.Adj w u) :
    G.IsIndepSet (Insert.insert w (s \ {v})) :=
  (hs.subset Set.sdiff_subset).insert fun b hb _ ↦ hw b hb

end SimpleGraph
