# Contributing to this submission

1. The package is named `ChainBounding`; its compared declarations live in
   `Challenge.lean` (statements, with `sorry`) and `Solution.lean` (proofs
   with identical statements).
2. Keep `Challenge.lean` a small, independently auditable statement surface.
   Its imports must satisfy the current Palomar policy (Lean core and Mathlib
   only); any new definitions there need precise docstrings.
3. Corresponding proofs belong in `Solution.lean`, which may import further
   pinned Git dependencies. Run `lake build` after every change.
4. Update `comparator.json` with every advertised theorem and any definition
   holes. Definition holes require special editorial scrutiny.
5. Keep `formalization.yaml` honest and independently checkable. Run
   `ruby scripts/validate-formalization.rb`; it parses the file and lists
   every retained template sentinel. Lists described as required in the
   adjacent comments must remain nonempty.
6. After changing dependencies, run `lake update` and
   `(cd docbuild && MATHLIB_NO_CACHE_ON_UPDATE=1 lake update)`, then commit
   both manifest files.
7. Run `lake build`, build the docs, and run Comparator before submitting to
   Palomar.
