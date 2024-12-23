#!/bin/bash

REPO_URL="https://github.com/Verlangid11/nebulafiles.git"
BASE_DIR="/var/www"
NEBULA_DIR="${BASE_DIR}/nebulafiles"
NEBULA_SCRIPT="${BASE_DIR}/nebula.sh"
NEBULA_ZIP="${BASE_DIR}/nebulaptero.zip"

echo "================================================"
echo "MEMULAI PROSES INSTALASI "
echo "DIBUAT OLEH VERLANG"
echo "================================================"

git clone "${REPO_URL}" "${NEBULA_DIR}"

mv "${NEBULA_DIR}/nebula.sh" "${NEBULA_SCRIPT}"
mv "${NEBULA_DIR}/nebulaptero.zip" "${NEBULA_ZIP}"

rm -rf "${NEBULA_DIR}"

cd "${BASE_DIR}" || exit
bash "${NEBULA_SCRIPT}"

unzip -o "${NEBULA_ZIP}" -d "${BASE_DIR}"

rm -f "${NEBULA_ZIP}"

echo "================================================"
echo "SEMUA PROSES TELAH OTOMATIS DILAKUKAN."
echo "DIBUAT DAN DISEMPURNAKAN OLEH VERLANG - ID"
echo "================================================"
