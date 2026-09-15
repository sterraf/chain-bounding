import Mathlib.Order.Preorder.Chain
import Mathlib.Order.CompletePartialOrder

/-!
# Chain Bounding: the statement surface

This file is the small, trusted statement surface a mathematical reader should
audit. It states the core results of the paper *Chain bounding, the leanest
proof of Zorn's lemma, and an illustration of computerized proof
formalization*, by Guillermo L. Incatasciato and Pedro Sánchez Terraf, which
was published in the *American Mathematical Monthly*; a preprint is freely
accessible at <http://arxiv.org/abs/2404.11638>.

The paper develops the notion of a *good* chain for an "expander" of subsets
of a poset and proves:

* the comparability of good chains and the existence of a *greatest good
  chain* for every expander (`OrderExpander.greatest_good_chain`);
* that every good chain for an expander of the form `C ↦ C ∪ {f C}`
  (`OrderSelector`) is well-ordered by the strict order of the poset
  (`OrderSelector.wellOrdered_of_good`);
* the *Chain Bounding* principle: there is no assignment of a strict upper
  bound to every chain of a poset (`ChainBounding.chain_bounding`), and its
  consequence, the *Unbounded Chain Lemma* (`unbounded_chain`);
* Zorn's Lemma (`zorn`) and the Bourbaki–Witt fixed point theorem
  (`bourbaki_witt_of_complete`).

One novelty of the paper is an alternative, *unified* approach: both Zorn's
Lemma and the Bourbaki–Witt fixed point theorem are derived from the very same
Unbounded Chain Lemma, avoiding ordinals and transfinite recursion. This is
recorded in the docstrings of `zorn` and `bourbaki_witt_of_complete`.

The corresponding proofs are supplied, with identical statements, in
`Solution.lean`. The correspondence with the paper's statements is:

| Paper                            | This file                          |
| -------------------------------- | ---------------------------------- |
| Theorem `th:greatest-good-chain` | `OrderExpander.greatest_good_chain`|
| Proposition `prop:good-well-ordered` | `OrderSelector.wellOrdered_of_good` |
| Lemma `lem:chain-bounding`       | `ChainBounding.chain_bounding`     |
| Lemma `lem:unbounded-chain`      | `unbounded_chain`                  |
| Corollary [Zorn]                 | `zorn`                             |
| Corollary [Bourbaki-Witt]        | `bourbaki_witt_of_complete`        |
-/

variable {α : Type*}

open Set IsChain

section Segment

/--
The binary relation of being an *initial segment*, viz., a decreasing subset.
-/
def IsSegment [LE α] (S C : Set α) : Prop := S ⊆ C ∧ ∀ c ∈ C, ∀ s ∈ S, c ≤ s → c ∈ S

/--
The binary relation of being an *proper* initial segment, that is, different from the whole.
-/
def IsPropSegment [LE α] (S C : Set α) : Prop := IsSegment S C ∧ S ≠ C

@[inherit_doc]
infix:70 " ⊏ " => IsPropSegment

@[inherit_doc]
infix:70 " ⊑ " => IsSegment

section GreatestGood

/--
A partial order with an *expander* function from subsets to subsets. In main applications, the
expander actually returns a bigger subset.
-/
class OrderExpander (α : Type*) [PartialOrder α] where
  /--
  The “expander” function.
  -/
  g : Set α → Set α

namespace OrderExpander

variable [PartialOrder α] [OrderExpander α]

/--
A chain is *good* if the successor of a proper segment is a greater segment.
-/
def Good (C : Set α) := IsChain (· ≤ ·) C ∧ ∀ {S}, S ⊏ C → S ⊏ g S ∧ g S ⊑ C

/--
The greatest good chain: the union of all good chains.
-/
def U : Set α :=  ⋃₀ {C | Good C}

/--
The existence of a *greatest good chain*: the union `U` of all good chains is
itself good, so it is a maximum, under inclusion, of the family of all good
chains. This is Theorem `th:greatest-good-chain` of the paper.
-/
lemma greatest_good_chain : Good (U (α := α)) := by
  sorry

end OrderExpander

end GreatestGood

section good_implies_well

/--
A partial order with a function that assigns elements of the base type to every subset
(not necessarily members of the subset).
-/
class OrderSelector (α : Type*) [PartialOrder α] where
  /--
  The “selector” function.
  -/
  f : Set α → α

instance [PartialOrder α] [OrderSelector α] : OrderExpander α := ⟨fun C => C ∪ {OrderSelector.f C}⟩

end good_implies_well

section GoodWellOrdered

variable [PartialOrder α] [OrderSelector α]

open OrderExpander

namespace OrderSelector

/--
Every good chain for the successor function `C ↦ C ∪ {f C}` is well-ordered by the strict
order of the poset, in the sense that every nonempty subset of the chain has a least
element. This is Proposition `prop:good-well-ordered` of the paper, restricted to the
`OrderSelector` setting.
-/
lemma wellOrdered_of_good {C : Set α} (hC : Good C) (X : Set α) (hXC : X ⊆ C)
    (hne : X.Nonempty) : ∃ m ∈ X, ∀ y ∈ X, m ≤ y := by
  sorry

end OrderSelector

end GoodWellOrdered

section ChainBounding

/--
A partial order with a function assigning elements of the base type to every subset, such
that for a chain `C`, `f C` is a strict upper bound of `C`.
-/
class ChainBounding (α : Type*) [PartialOrder α] [OrderSelector α] : Prop where
  -- `strbds` below means *strictly bounds*.
  strbds : ∀ C, IsChain (· ≤ ·) C → ∀ a ∈ C, a < OrderSelector.f (α := α) C

variable [PartialOrder α] [OrderSelector α] [ChainBounding α]

open OrderSelector OrderExpander

namespace ChainBounding

include α in
/--
There is no assigment of a strict upper bound to each chain in a poset. This is
Lemma `lem:chain-bounding` (Chain Bounding) of the paper, stated as the
negation (the impossibility of the conditions holding), as there.
-/
lemma chain_bounding : False := by
  sorry

end ChainBounding

end ChainBounding

/--
Every poset has a chain without strict upper bounds. This is the Unbounded
Chain Lemma, Lemma `lem:unbounded-chain` of the paper; the paper invokes the
Axiom of Choice to select strict upper bounds, while the present statement is
for inhabited posets and its proof uses classical logic.
-/
lemma unbounded_chain [PartialOrder α] [Inhabited α] :
    ∃ C, IsChain (· ≤ ·) C ∧ ¬ ∃ sb : α, ∀ a ∈ C, a < sb := by
  sorry

section Zorn

/--
Maximal elements of a poset.
-/
def IsMaximal [LE α] (m : α) := ∀ z, m ≤ z → z = m

/--
Zorn's Lemma: a poset in which every chain has an upper bound has a maximal
element. In the paper (Corollary [Zorn]) this is derived from the Unbounded
Chain Lemma; one novelty of the paper is this alternative, unified approach,
which avoids ordinals and transfinite recursion.
-/
lemma zorn [PartialOrder α] [Inhabited α]
    (ind : ∀ (C : Set α), IsChain (· ≤ ·) C → ∃ ub, ∀ a ∈ C, a ≤ ub) : ∃ (x : α), IsMaximal x := by
  sorry

end Zorn

section BourbakiWitt

/--
The Bourbaki–Witt fixed point theorem: a chain-complete poset (with directed
suprema) and an expansive map `g` have a fixed point. In the paper (Corollary
[Bourbaki-Witt]) this is likewise derived from Chain Bounding, sharing with
`zorn` the unified approach noted there.
-/
theorem bourbaki_witt_of_complete [CompletePartialOrder α] (g : α → α) (hg : ∀x, x ≤ g x) :
    ∃ x, g x = x := by
  sorry

end BourbakiWitt
