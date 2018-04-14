#!/bin/sh

set -x
set -e

BRANCH="master"
NCPU=`sysctl -n hw.ncpu`
REPO="https://github.com/elstevi/freebsd.git"
SRCDIR="${WORK_DIR}/src"

mkdir -p ${SRCDIR}

git clone -b ${BRANCH} ${REPO} ${SRCDIR}
cd ${SRCDIR}; make -j ${NCPU} buildworld
cd ${SRCDIR}; make -j ${NCPU} buildkernel
cd ${SRCDIR}/release; make -j ${NCPU} packagesystem

cp -R ${SRCDIR}/release/*.txz ${DIST_DROP_DIR}
cp -R ${SRCDIR}/release/MANIFEST ${DIST_DROP_DIR}
