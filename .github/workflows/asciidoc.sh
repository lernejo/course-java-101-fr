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

echo "Rendering HTML5..."
asciidoctor -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/html/ -o index.html -a ci=ci -a imagesdir="images" -a lang=fr -r asciidoctor-diagram index.adoc

echo "Rendering PDF..."
asciidoctor-pdf -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/pdf/ -o index.pdf -a ci=ci -a imagesdir="${CURRENT_PATH}/images" -a lang=fr -a scripts@=cjk -a pdf-styledir=${CURRENT_PATH}/themes -a pdf-fontsdir=${CURRENT_PATH}/fonts -r asciidoctor-diagram index.adoc

echo "Rendering EPUB..."
asciidoctor-epub3 -B ${CURRENT_PATH}/ -D ${CURRENT_PATH}/outputs/epub/ -o index.epub -r asciidoctor-diagram -a ci=ci -a imagesdir="${CURRENT_PATH}/images" -a lang=fr index.adoc
