# Chain Bounding — a Palomar submission

[![CI](https://github.com/sterraf/chain-bounding/actions/workflows/ci.yml/badge.svg)](https://github.com/sterraf/chain-bounding/actions/workflows/ci.yml)

A [Palomar](https://palomar-registry.org/) submission formalizing the core
results of *Chain bounding, the leanest proof of Zorn's lemma, and an
illustration of computerized proof formalization* by Guillermo L. Incatasciato
and Pedro Sánchez Terraf. The paper was published in the *American
Mathematical Monthly*, and a preprint is freely accessible at
<http://arxiv.org/abs/2404.11638>.

The formalization is due to Pedro Sánchez Terraf; the mathematical results are
joint work with Guillermo L. Incatasciato.

## What is formalized

For a poset `α` and a function `g` from its subsets to its subsets, a chain is
*good* (for `g`) when the `g`-successor of each proper initial segment is a
larger segment of it. The development proves:

- the comparability of good chains and the existence of a *greatest good
  chain* for every expander (`OrderExpander.greatest_good_chain`);
- that every good chain for an expander of the form `C ↦ C ∪ {f C}` is
  well-ordered by the strict order of the poset
  (`OrderSelector.wellOrdered_of_good`, Proposition `prop:good-well-ordered`
  of the paper);
- the *Chain Bounding* principle — there is no assignment of a strict upper
  bound to every chain of a poset (`ChainBounding.chain_bounding`) — and its
  consequence, the *Unbounded Chain Lemma* (`unbounded_chain`);
- Zorn's Lemma (`zorn`) and the Bourbaki–Witt fixed point theorem
  (`bourbaki_witt_of_complete`).

One novelty of the paper is an alternative, *unified* approach to the last two
results: both Zorn's Lemma and the Bourbaki–Witt fixed point theorem are
derived from the very same Unbounded Chain Lemma, avoiding ordinals and
transfinite recursion.

## Repository map

- `Challenge.lean` is the small statement surface a mathematical reader
  audits: the prerequisite definitions, each with a precise docstring, and the
  six advertised results stated without proofs.
- `Solution.lean` supplies the proofs for those exact statements, together
  with the supporting development (segment lemmas, comparability of good
  chains, well-orderedness, and the successor construction).
- `comparator.json` tells [Comparator](https://github.com/leanprover/comparator)
  which declarations must match.
- `formalization.yaml` records the public result description, provenance,
  authorship, automation, fidelity, and review information.
- `LICENSE` contains the Apache License 2.0 terms declared by
  `project.license`.
- `docbuild/` is the nested doc-gen4 project.
- `scripts/verify-comparator.sh` runs pinned Comparator, lean4export, NanoDa,
  and Landrun revisions using the checked-in `comparator.json`, which enables
  the independent NanoDa replay; `scripts/landrun-wrapper.sh` preserves
  lean4export's command delimiter when invoked through Landrun's current CLI.

The root uses `lakefile.toml`, the Lean toolchain `v4.34.0-rc2`, and a Mathlib
revision pinned in `lakefile.toml` (with the resolved full commit SHA recorded
in `lake-manifest.json`).

## Building and checking

```text
lake exe cache get
lake build
(cd docbuild && lake build Challenge:docs Solution:docs)
ruby scripts/validate-formalization.rb
./scripts/verify-comparator.sh
```

The full check set requires Linux, Git, Go, Ruby, Rust/Cargo, Python 3, and a
working Landrun sandbox; the Comparator script pins and builds each tool at
its recorded revision.

## Submitting

Read the current
[Palomar submission policy](https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md)
and [open the submission form](https://submit.palomar-registry.org/) with the
full 40-character commit SHA of the final snapshot. Questions are welcome in
the [Palomar channel on the Lean Zulip](https://leanprover.zulipchat.com/#narrow/channel/621638-Palomar).
