#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KEY="${REPO_ROOT}/keys/k8s-platform-ed25519"
KNOWN_HOSTS="${REPO_ROOT}/ssh/known_hosts"
HOST="ubuntu@3.79.57.201"

echo "Opening SSH tunnel: localhost:6443 -> ${HOST}:127.0.0.1:6443"
echo "Press Ctrl+C to close."

exec ssh \
  -i "${KEY}" \
  -o StrictHostKeyChecking=yes \
  -o UserKnownHostsFile="${KNOWN_HOSTS}" \
  -L 6443:127.0.0.1:6443 \
  "${HOST}"
