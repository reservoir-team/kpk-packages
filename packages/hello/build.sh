#!/bin/sh
# packages/hello/build.sh
# Builds GNU Hello from source and stages output into $OUT_DIR
# following the .kpk layout convention (bin/ folder etc).

set -e

NAME="hello"
VERSION="2.12.1"
OUT_DIR="$1"   # passed by the workflow

mkdir -p "$OUT_DIR/binary"

wget -nc "https://ftp.gnu.org/gnu/hello/hello-${VERSION}.tar.gz"
tar -xf "hello-${VERSION}.tar.gz"
cd "hello-${VERSION}"

./configure --prefix=/usr
make -j"$(nproc)"

cp -v hello "$OUT_DIR/binary/hello"

cat > "$OUT_DIR/.kpkmeta" << EOF
{
  "name": "$NAME",
  "version": "$VERSION",
  "type": ["binary"],
  "dependencies": [],
  "permissions": "755"
}
EOF

echo "$NAME $VERSION build complete"
