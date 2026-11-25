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

Redis is an in-memory data store and data structure server: strings, lists, sets, hashes, sorted sets, streams and JSON, with key expiry, pub/sub, and search and vector query features.

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

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/redis/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
