/-
Copyright (c) 2026 Duc A. Hoang. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Duc A. Hoang
-/
module

public import Mathlib.Combinatorics.SimpleGraph.Clique

/-!
# Insertion and monotonicity lemmas for independent sets

This file supplies `SimpleGraph.IsIndepSet` analogues of the insertion and
monotonicity lemmas that `Mathlib/Combinatorics/SimpleGraph/Clique.lean` proves
for `SimpleGraph.IsClique` (`isClique_insert`, `IsClique.insert`,
`IsClique.subset`, `IsClique.mono`). They are stated here until they are
upstreamed into that file.

## Main statements

* `SimpleGraph.isIndepSet_insert`: characterisation of independence of
  `insert a s`.
* `SimpleGraph.IsIndepSet.insert`: inserting a vertex that is adjacent to no
  vertex of an independent set keeps the set independent.
* `SimpleGraph.IsIndepSet.subset`: a subset of an independent set is
  independent.
* `SimpleGraph.IsIndepSet.anti`: an independent set stays independent in any
  subgraph.
-/

@[expose] public section

namespace SimpleGraph

variable {α : Type*} {G H : SimpleGraph α} {s t : Set α} {a : α}

@[simp]
theorem isIndepSet_insert :
    G.IsIndepSet (insert a s) ↔ G.IsIndepSet s ∧ ∀ b ∈ s, a ≠ b → ¬G.Adj a b :=
  Set.pairwise_insert.trans <| and_congr_right fun _ ↦ forall₃_congr fun _ _ _ ↦
    ⟨fun h ↦ h.1, fun h ↦ ⟨h, fun ha ↦ h ha.symm⟩⟩

theorem IsIndepSet.insert (hs : G.IsIndepSet s) (h : ∀ b ∈ s, a ≠ b → ¬G.Adj a b) :
    G.IsIndepSet (insert a s) :=
  isIndepSet_insert.mpr ⟨hs, h⟩

@[gcongr]
theorem IsIndepSet.subset (h : t ⊆ s) : G.IsIndepSet s → G.IsIndepSet t :=
  Set.Pairwise.mono h

theorem IsIndepSet.anti (h : G ≤ H) : H.IsIndepSet s → G.IsIndepSet s :=
  Set.Pairwise.mono' fun _ _ hn ha ↦ hn (h ha)

end SimpleGraph
