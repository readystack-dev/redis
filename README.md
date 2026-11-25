# Redis: ReadyStack build kit

The offline build kit for the Docker image `readystack/redis:8.10.3-CE-ubuntu24.04-r4`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [8.10.3-CE-ubuntu24.04-r4](https://github.com/readystack-dev/redis/releases/tag/8.10.3-CE-ubuntu24.04-r4)
- Image: [`docker.io/readystack/redis:8.10.3-CE-ubuntu24.04-r4`](https://hub.docker.com/r/readystack/redis/tags), manifest digest `sha256:2383e041d63b3b3d082e72485cd1c69d82fa6d6d1906d729058ef7da82f4b3f3`
- Product page: https://readystack.dev/products/redis
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=redis

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
