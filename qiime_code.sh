# Activate Qiime2

wsl
conda updata conda
conda activate qiime2

# Paired end on top, Single end on bottom
# Import data from SRA and create manifest file

ls -d "$PWD/"*_1.fastq.gz
ls -d "$PWD/"*_2.fastq.gz

ls -d "$PWD/"*.fastq.gz

# Convert to .qza

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path name_manifest.txt \
  --output-path name-paired-end-demux.qza \
  --input-format PairedEndFastqManifestPhred33V2

qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path name_manifest.txt \
  --output-path name-single-end-demux.qza \
  --input-format SingleEndFastqManifestPhred33V2

# Convert to .qzv to check read quality

qiime demux summarize \
  --i-data name-paired-end-demux.qza \
  --o-visualization name-paired-end-demux.qzv

qiime demux summarize \
  --i-data name-single-end-demux.qza \
  --o-visualization name-single-end-demux.qzv

# Dada2

qiime dada2 denoise-paired \
--i-demultiplexed-seqs name-paired-end-demux.qza \
--p-trunc-len-f 150 \
--p-trunc-len-r 150 \
--p-trim-left-f 0 \
--p-trim-left-r 0 \
--p-n-threads 8 \
--o-representative-sequences name-rep-seqs-dada.qza \
--o-table name-table.qza \
--o-denoising-stats name-stats-dada.qza

qiime dada2 denoise-single \
  --i-demultiplexed-seqs name-single-end-demux.qza \
  --p-trunc-len 150 \
  --p-trim-left 0 \
  --p-n-threads 8 \
  --o-representative-sequences name-rep-seqs.qza \
  --o-table name-table.qza \
  --o-denoising-stats name-stats.qza