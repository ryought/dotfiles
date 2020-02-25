#!/bin/bash
# run juicer in all-in-one command
# ./juice.sh

set -Ceuo pipefail
cd $(dirname $0)

if [ $# -ne 6 ]; then
	echo "not enough args" 1>&2
  echo "usage: bash juice.sh PROJECT_NAME READ_R1 READ_R2 REF_FASTA ENZYME_NAME PROJECT_DIR (these should be abs path)" 1>&2
	exit 1
fi

PROJECT_NAME=$1
READ_R1=$2
READ_R2=$3
REF_FASTA=$4
ENZYME=$5  # DpnII
PROJECT_DIR=$6


JUICEBOX_DIR='/work/ryought/tools/juicer'

echo creating workspace named $PROJECT_DIR

mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
ls

# /scripts
ln -s $JUICEBOX_DIR/CPU scripts

# /fastq
mkdir fastq
cd fastq
ln -s $READ_R1 read_R1.fastq
ln -s $READ_R2 read_R2.fastq

# /references
cd ..
mkdir references
cd references
ln -s $REF_FASTA ref.fasta
bwa index ref.fasta

# /restriction_sites
cd ..
mkdir restriction_sites
cd restriction_sites
python2 $JUICEBOX_DIR/misc/generate_site_positions.py \
  $ENZYME \
  $PROJECT_NAME \
  ../references/ref.fasta
awk 'BEGIN{OFS="\t"}{print $1, $NF}' ${PROJECT_NAME}_${ENZYME}.txt > ${PROJECT_NAME}.chrom.sizes

# run
cd ..
export PERL5LIB=/usr/share/perl5/
./scripts/juicer.sh \
  -D . \
  -z references/ref.fasta \
  -p restriction_sites/${PROJECT_NAME}.chrom.sizes \
  -y restriction_sites/${PROJECT_NAME}_${ENZYME}.txt
