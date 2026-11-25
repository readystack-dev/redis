# Provenance — Redis (`8.10.3-CE-ubuntu24.04-r4`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/redis/redis
- Revision built: `8.10.3` (commit `1a2574ce1551d3de6e0b4a56756c0fdbc6659e4f`)
- Source tree: `3cc51f57686121c417ad1c10785daa1815233a26de8445924cdb7ce7a089be24` over 1861 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-c`; base image `scratch + a chiselled Ubuntu 24.04 runtime (vendored/chisel/slices.txt, packages.tsv)`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795161219` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/redis:8.10.3-CE-ubuntu24.04-r4` — index digest `sha256:ab9cf53b2a66ecbad47e138e77d20e42a9f78d8b7fc62ba0c8924d30d083b9fc` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:2383e041d63b3b3d082e72485cd1c69d82fa6d6d1906d729058ef7da82f4b3f3` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redis:8.10.3-CE-ubuntu24.04-r4`

## Pinned inputs, and why

- 23 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 2, dependency versions readystack sets 3, pins in the kit's dockerfiles 5, readystack's build engine 6, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.trail.json`, published beside this archive and signed with the release key (`ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.trail.json.sigstore`), and readable at https://readystack.dev/products/redis/trail/8.10.3-CE-ubuntu24.04-r4.

