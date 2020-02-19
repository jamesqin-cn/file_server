#!/bin/sh

DOC_ROOT=${DOC_ROOT:-/data}
LOG_DIR=${LOG_DIR:-/logs}

mkdir -p ${LOG_DIR}
mkdir -p ${DOC_ROOT}

/bin/file_server -host=:80 -doc_root=${DOC_ROOT} -log_dir=${LOG_DIR} -alsologtostderr
