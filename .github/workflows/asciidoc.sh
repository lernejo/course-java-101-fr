#!/bin/bash
set -e

mkdir -p ./outputs/pdf
mkdir -p ./outputs/html
mkdir -p ./outputs/epub
mkdir ./themes

CURRENT_PATH=`pwd`
ASCIIDOCTOR_PDF_DIR=`gem contents asciidoctor-pdf --show-install-dir`

cp "${ASCIIDOCTOR_PDF_DIR}/data/themes/default-theme.yml" ${CURRENT_PATH}/themes/default-theme.yml
cp -r -f "${ASCIIDOCTOR_PDF_DIR}/data/fonts/" ${CURRENT_PATH}/

asciidoctor -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/html/ -o index.html  -a imagesdir=${CURRENT_PATH}/images  -r asciidoctor-diagram   index.adoc

asciidoctor-pdf -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/pdf/ -o index.pdf -a imagesdir=${CURRENT_PATH}/images  -a scripts@=cjk  -a pdf-styledir=${CURRENT_PATH}/themes -a pdf-fontsdir=${CURRENT_PATH}/fonts -r asciidoctor-diagram  index.adoc

asciidoctor-epub3 -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/epub/ -o index.epub  -r asciidoctor-diagram -a imagesdir=${CURRENT_PATH}/images   index.adoc
