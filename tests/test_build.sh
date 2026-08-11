#!/usr/bin/env bash
# tests/test_build.sh — verifies `make build` produces a faithful old-school site.
set -euo pipefail
cd "$(dirname "$0")/.."

echo ">>> make clean + make build"
make clean >/dev/null 2>&1 || true
make build >/dev/null

echo ">>> assert expected output files exist"
for f in \
  docs/index.html \
  docs/syllabus.html \
  docs/resources.html \
  docs/01-introduction.html \
  docs/02-foundations.html \
  docs/problem-sheets.html \
  docs/00-appendix.pdf \
  docs/style.css
do
  test -f "$f" || { echo "FAIL: missing $f"; exit 1; }
done

echo ">>> assert old-school aesthetic elements"
# centered header block (from index.md raw HTML) rendered, not stripped
grep -q 'class="center"' docs/index.html || { echo "FAIL: centered header missing in index"; exit 1; }
# horizontal rule present (markdown --- -> <hr>)
grep -q '<hr>' docs/syllabus.html || { echo "FAIL: <hr> missing in syllabus"; exit 1; }
# stylesheet link present
grep -q 'href="style.css"' docs/01-introduction.html || { echo "FAIL: stylesheet link missing"; exit 1; }
# page <title> set from front-matter
grep -q '<title>Semana 1' docs/01-introduction.html || { echo "FAIL: title missing"; exit 1; }
# nav links present and flat (relative, no leading slash)
grep -q 'href="02-foundations.html"' docs/index.html || { echo "FAIL: nav link missing"; exit 1; }

echo "BUILD TESTS PASSED"
