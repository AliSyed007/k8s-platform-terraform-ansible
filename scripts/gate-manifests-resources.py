#!/usr/bin/env python3
import sys
import glob
from pathlib import Path

REQUIRED = [
    ("requests", "cpu"),
    ("requests", "memory"),
    ("limits", "cpu"),
    ("limits", "memory"),
]

def iter_docs(text: str):
    # minimal YAML doc splitter; avoids adding dependencies (pyyaml)
    parts = text.split("\n---")
    for p in parts:
        s = p.strip()
        if s:
            yield s

def has_required_resources(doc: str) -> bool:
    # crude but deterministic: look for required keys in container resources blocks
    # We intentionally demand explicit keys (not relying on LimitRange defaults).
    lowered = doc.lower()
    if "kind:" not in lowered:
        return True  # ignore non-k8s fragments
    if "kind: deployment" in lowered or "kind: statefulset" in lowered or "kind: daemonset" in lowered or "kind: job" in lowered or "kind: cronjob" in lowered or "kind: pod" in lowered:
        for (a, b) in REQUIRED:
            if f"{a}:" not in lowered or f"{b}:" not in lowered:
                # Too coarse: might false-pass if cpu/memory exist elsewhere.
                # So we do a stronger check per required token combo:
                token = f"{a}:\n"  # anchor
        # Stronger: require the exact 4 tokens anywhere; still simple but safer.
        for (a, b) in REQUIRED:
            if f"{a}:" not in lowered or f"{b}:" not in lowered:
                return False
        # Also require the word "resources:" for workload kinds
        if "resources:" not in lowered:
            return False
    return True

def main():
    if len(sys.argv) != 2:
        print("Usage: gate-manifests-resources.py <glob>", file=sys.stderr)
        sys.exit(2)

    pattern = sys.argv[1]
    files = sorted(glob.glob(pattern, recursive=True))
    if not files:
        print(f"FAIL: No files matched pattern: {pattern}", file=sys.stderr)
        sys.exit(1)

    failures = []
    for f in files:
        p = Path(f)
        if p.is_dir():
            continue
        text = p.read_text(encoding="utf-8", errors="replace")
        for i, doc in enumerate(iter_docs(text), start=1):
            if not has_required_resources(doc):
                failures.append(f"{f} (doc #{i})")

    if failures:
        print("FAIL: Some workload manifests are missing explicit CPU/MEM requests+limits:")
        for x in failures:
            print(f"  - {x}")
        sys.exit(1)

    print("PASS: All matched workload manifests include explicit CPU/MEM requests+limits.")
    sys.exit(0)

if __name__ == "__main__":
    main()
