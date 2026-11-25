# Redis 8.10.3 — ReadyStack release `8.10.3-CE-ubuntu24.04-r4`

Generated 2026-11-20 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/redis:8.10.3-CE-ubuntu24.04-r4` (linux/amd64). Index digest `sha256:ab9cf53b2a66ecbad47e138e77d20e42a9f78d8b7fc62ba0c8924d30d083b9fc` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:2383e041d63b3b3d082e72485cd1c69d82fa6d6d1906d729058ef7da82f4b3f3` [`TARGET_DIGEST.txt`].
- **Upstream:** Redis 8.10.3 built from source at `8.10.3` of https://github.com/redis/redis — upstream notes: https://github.com/redis/redis/releases/tag/8.10.3 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** none (`FROM scratch`): a chiselled Ubuntu 24.04 runtime, the files Canonical's chisel cut from Ubuntu's own packages (`vendored/chisel/slices.txt`, `vendored/chisel/packages.tsv`); runtime user `redis`.
- **Build:** `source-rebuild-c`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `8.10.3-CE-ubuntu24.04-r3`.

## What changed in this release

- Upstream version unchanged (8.10.3); ReadyStack rebuild.
- Redis 8.10.3 is unchanged from the release this supersedes (8.10.3-CE-ubuntu24.04-r3); this release rebuilds it. Changes: the image is rebuilt on the current ubuntu:24.04 image (sha256:9c7f200c07e3…), which its maintainers updated after 8.10.3-CE-ubuntu24.04-r3 was built on sha256:2198e4c65076…. Settings, ports and data volumes are those of 8.10.3-CE-ubuntu24.04-r3: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-20)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `redis` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redis:8.10.3-CE-ubuntu24.04-r4` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** Clients on other hosts can connect only after you set REDIS_PASSWORD (requirepass); without it the server accepts only in-container clients. The shipped configuration has no TLS: keep the port on a private network, or enable tls-port with your own certificates (redis-server is built with TLS support).

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:2383e041d63b3b3d082e72485cd1c69d82fa6d6d1906d729058ef7da82f4b3f3`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 8 of 8 use cases passed (8 authored) against the running image [`docs/validation/test-results.json`].

## Known issues

- None found (reviewed by held semantic review (Claude) on 2026-11-20).

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redis:8.10.3-CE-ubuntu24.04-r4
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

