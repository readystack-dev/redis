# GENERATED L-009 hermetic C build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned bases; vendored source (in-tree deps) + extra build debs + runtime debs from Dockerfile.vendor.
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS cbuild
# dpkg-install the vendored EXTRA build debs (pkg-config/libssl-dev/...) — gcc/make are in the builder.
RUN --mount=type=bind,source=vendored/build-debs,target=/tmp/bdebs \
    set --; for f in /tmp/bdebs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; }
WORKDIR /src
COPY vendored/redis-src/ .
ARG SOURCE_DATE_EPOCH=1795161219
ENV SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH}
ENV BUILD_TLS=yes
RUN make -j"$(nproc)" BUILD_TLS=yes
RUN make install PREFIX=/opt/redis BUILD_TLS=yes
RUN set -eu; find /opt/redis -type f | LC_ALL=C sort | while read -r f; do \
      readelf -h "$f" >/dev/null 2>&1 || continue; \
      readelf -lW "$f" | sed -n 's/.*Requesting program interpreter: \(.*\)]$/\1/p'; \
      readelf -dW "$f" | sed -n 's/.*Shared library: \[\(.*\)\]$/\1/p'; \
    done | LC_ALL=C sort -u | while read -r lib; do case "$lib" in \
      /*) echo "$lib" ;; *) [ -n "$(find /opt/redis -name "$lib" -print -quit)" ] || echo "$lib" ;; esac; \
    done > /kitforge.needs && echo "the install prefix loads: $(tr '\n' ' ' < /kitforge.needs)"
# rs-probe: the HEALTHCHECK helper (standard library only, from the kit's rs-probe.go)
FROM golang:1.27.3-bookworm@sha256:972b4110ba0f47539a975c31e52c64765e1ff19f2d74469ae4a595c6676e80a5 AS build_rs_probe
WORKDIR /probe
COPY rs-probe.go main.go
COPY rs-probe.mod go.mod
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOFLAGS="-buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1795161219
RUN go build -trimpath -ldflags='-s -w' -o /rs-probe .
# the chiselled rootfs (vendored/chisel, cut by Dockerfile.vendor), the service user, the binaries
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS rootfs
ARG SOURCE_DATE_EPOCH=1795161219
ADD vendored/chisel/rootfs.tar /rootfs/
RUN printf 'redis:x:999:999::/data:/bin/sh\n' >> /rootfs/etc/passwd && printf 'redis:x:999:\n' >> /rootfs/etc/group && \
    mkdir -p /rootfs/data /rootfs/etc/redis && chown -R 999:999 /rootfs/data /rootfs/etc/redis
COPY --from=build_rs_probe /rs-probe /rootfs/usr/local/bin/rs-probe
COPY redis.conf /rootfs/etc/redis/redis.conf
COPY readystack-entrypoint.sh /rootfs/usr/local/bin/readystack-entrypoint.sh
COPY --from=cbuild /opt/redis /rootfs/opt/redis
COPY --from=cbuild /kitforge.needs /tmp/needs/redis
RUN chmod 755 /rootfs/usr/local/bin/rs-probe && \
    chmod 0755 /rootfs/usr/local/bin/readystack-entrypoint.sh
RUN --mount=type=bind,source=vendored/chisel,target=/chisel set -eu; \
    for n in /tmp/needs/*; do while read -r lib; do [ -n "$lib" ] || continue; \
      case "$lib" in /*) [ -e "/rootfs$lib" ] ;; *) [ -n "$(find /rootfs/usr/lib /rootfs/usr/lib64 -name "$lib" 2>/dev/null | head -1)" ] ;; esac || \
      { echo "$(basename "$n") needs $lib, which the chiselled rootfs does not have: add its slice to runtime_base.slices" >&2; exit 1; }; \
    done < "$n"; done; rm -rf /tmp/needs; \
    [ -e /rootfs/etc/os-release ] || { echo "no /etc/os-release: base-files_release-info is missing" >&2; exit 1; }; \
    [ "$(grep -c '^Package: ' /rootfs/var/lib/dpkg/status)" = "$(wc -l < /chisel/packages.tsv)" ] || \
      { echo "/var/lib/dpkg/status does not list every package of vendored/chisel/packages.tsv" >&2; exit 1; }; \
    rm -rf /rootfs/var/log/dpkg.log /rootfs/var/log/alternatives.log /rootfs/var/log/apt /rootfs/var/cache/ldconfig/aux-cache /rootfs/var/cache/fontconfig
FROM scratch
ARG SOURCE_DATE_EPOCH=1795161219
COPY --from=rootfs /rootfs/ /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin PATH=/opt/redis/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
LABEL org.opencontainers.image.licenses="AGPL-3.0-only"
LABEL org.opencontainers.image.title="Redis"
LABEL org.opencontainers.image.source="https://github.com/redis/redis"
LABEL org.opencontainers.image.description="Redis 8.10.3 in-memory key-value data store (core OSS, AGPLv3)"
LABEL org.opencontainers.image.version="8.10.3-CE-ubuntu24.04-r4"
LABEL com.readystack.license.disclosure="This image includes Redis (https://github.com/redis/redis) 8.10.3, distributed under the GNU AGPL-3.0-only option of the Redis 8.x tri-license (RSALv2/SSPLv1/AGPLv3). No modifications have been made to the Redis source code; security patches are applied only via vendored updates to upstream-published apt dependencies (unmodified). This is core Redis OSS only -- the bundled Query Engine modules and the proprietary Intel SVS optimizations are not included. ReadyStack license holders have access to the image build recipe and patched-package manifest on request via contact@readystack.dev."
LABEL org.opencontainers.image.revision="1a2574ce1551d3de6e0b4a56756c0fdbc6659e4f"
HEALTHCHECK --interval=5s --timeout=120s --start-period=5s \
  CMD if [ -n "$REDIS_PASSWORD" ]; then export REDISCLI_AUTH="$REDIS_PASSWORD"; fi; case "$(redis-cli -h 127.0.0.1 -p 6379 ping)" in PONG) ;; *) exit 1 ;; esac || exit 1
USER redis
EXPOSE 6379
ENTRYPOINT ["/usr/local/bin/readystack-entrypoint.sh"]
