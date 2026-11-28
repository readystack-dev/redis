[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fredis-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/redis) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/redis)](https://hub.docker.com/r/readystack/redis) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/redis) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# Redis: ReadyStack build kit

The offline build kit for the Docker image `readystack/redis:8.10.3-CE-ubuntu24.04-r4`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [8.10.3-CE-ubuntu24.04-r4](https://github.com/readystack-dev/redis/releases/tag/8.10.3-CE-ubuntu24.04-r4)
- Image: [`docker.io/readystack/redis:8.10.3-CE-ubuntu24.04-r4`](https://hub.docker.com/r/readystack/redis/tags), manifest digest `sha256:2383e041d63b3b3d082e72485cd1c69d82fa6d6d1906d729058ef7da82f4b3f3`
- Product page: https://readystack.dev/products/redis
- Source and build recipe: https://readystack.dev/products/redis/recipe
- Build trail: https://readystack.dev/products/redis/trail/8.10.3-CE-ubuntu24.04-r4
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=redis

## The image

Single container, single self-contained C binary (redis-server) compiled from source, foreground process (PID 1). An in-memory key-value data store; state persists to disk as an RDB snapshot (and optionally an AOF) under /data. NO relational/SQL database, NO external datastore, NO sidecar. The image IS the complete running instance (no docker-compose, no cluster).

## Who uses Redis and why

Developers building applications that need fast access to data: caches, sessions, queues, leaderboards and real-time features.

Redis is an in-memory data store and data structure server: strings, lists, sets, hashes, sorted sets, streams and vector sets, with key expiry and pub/sub.

A typical use: A busy website keeps querying its main database for the same product pages and user sessions. With Redis in front, the site caches page data with an expiry time and stores sessions in memory, so most reads skip the main database and pages return faster.

From the upstream project's own description: https://github.com/redis/redis.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-20 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 17 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`redis`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-20; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/redis.

Redis is distributed under its upstream licence (AGPL-3.0-only); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [8.10.3-CE-ubuntu24.04-r4 release](https://github.com/readystack-dev/redis/releases/tag/8.10.3-CE-ubuntu24.04-r4): `ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.tar.gz` (525.8 MB), SHA-256 `acee11b7dcdb90311693502a01125efe267081426b261a4efd142521325dd00f`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.rebuild.json.sigstore ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.tar.gz
cd 8.10.3-CE-ubuntu24.04-r4
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-redis-8.10.3-CE-ubuntu24.04-r4.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/redis/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
