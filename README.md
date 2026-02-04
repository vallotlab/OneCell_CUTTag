# OneCell_CUT&Tag

This repository contains the code used for the downstream analysis and visualisation of the data from the **Schwager & Mouteaux, 2026** paper (Pubmed ID: **XXXX**).
\
Please, read the information below for the scripts description and reproducibility instructions.

## 0. Data availability
All raw and processed files produced in this study can be downloaded from GEO (**GSE290486**). 
Additional annotation and metadata files are present in this repository in the **annotation** and **metadata** folders.
Public data used in this analysis were downloaded from GEO (GSE164409: bulk H3K27me3 ChIP-seq for the MM468 cell line, GSE235109 (GSM7645420 sample) : H3K4me1 TACIT for zygotes).

## 1. Setup Instructions
To reproduce the analysis, the user should create the following folder structure on their local machine : 

```
.
├── annotation
├── input
├── output
└── scripts

```
The **annotation** and **scripts** folders should be cloned from this github repository as they are.
\
The **output** folder should be created and left empty. Its subfolders and content will be ctreated automatically while running the scripts. 
\
The **input** folder should be created by the user and organized as follows :

```
.
├── hg38
│   ├── MM468
│   │   ├── bigwigs
│   │   │   └── MM468_ATCC_hu_WT_AM_m10y22_H3K27me3.bw
│   │   ├── one_cell_cuttag
│   │   │   └── h3k27me3
│   │   │       └── fragmentFiles
│   │   │           ├── L589_MM468_H3K27me3_subsampled46.fragments.tsv.gz
│   │   │           └── L589_MM468_H3K27me3_subsampled46.fragments.tsv.gz.tbi
│   │   ├── one_cell_multiome
│   │   │   ├── flash
│   │   │   │   ├── 10XlikeMatrix_read
│   │   │   │   │   ├── barcodes.tsv
│   │   │   │   │   ├── genes.tsv
│   │   │   │   │   └── matrix.mtx
│   │   │   │   └── 10XlikeMatrix_umi
│   │   │   │       ├── barcodes.tsv
│   │   │   │       ├── genes.tsv
│   │   │   │       └── matrix.mtx
│   │   │   └── h3k27me3
│   │   │       └── fragmentFiles
│   │   │           ├── L589_MM-K27.fragments.tsv.gz
│   │   │           └── L589_MM-K27.fragments.tsv.gz.tbi
│   │   ├── sc_chicseq
│   │   │   └── h3k27me3
│   │   │       └── fragmentFiles
│   │   │           ├── chic_h3k27me3.fragments_prefixed.tsv.gz
│   │   │           └── chic_h3k27me3.fragments_prefixed.tsv.gz.tbi
│   │   ├── sc_chipseq
│   │   │   └── h3k27me3
│   │   │       └── fragmentFiles
│   │   │           ├── D937C02_MM468-H3K27me3_2000c.fragments.tsv.gz
│   │   │           └── D937C02_MM468-H3K27me3_2000c.fragments.tsv.gz.tbi
│   │   └── sc_cuttag_10x
│   │       └── h3k27me3
│   │           └── fragmentFiles
│   │               ├── N59N64_MM468BC_K27me3.fragments.tsv.gz
│   │               └── N59N64_MM468BC_K27me3.fragments.tsv.gz.tbi
│   └── frozen_PDX
│       └── one_cell_cuttag
│           └── h3k4me1
│               └── fragmentFiles
│                   ├── L512_PDX_BC152_P1_H3K4me1.fragments.tsv.gz
│                   ├── L512_PDX_BC152_P1_H3K4me1.fragments.tsv.gz.tbi
│                   ├── L512_PDX_BC152_P3_H3K4me1.fragments.tsv.gz
│                   └── L512_PDX_BC152_P3_H3K4me1.fragments.tsv.gz.tbi
└── mm10
    ├── mouse_mammary_gland
    │   └── one_cell_multiome
    │       ├── flash
    │       │   ├── D1888_10XlikeMatrix_read
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   ├── D1888_10XlikeMatrix_umi
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   ├── N173_10XlikeMatrix_read
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   ├── N173_10XlikeMatrix_umi
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   ├── P108_10XlikeMatrix_read
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   └── P108_10XlikeMatrix_umi
    │       │       ├── barcodes.tsv
    │       │       ├── genes.tsv
    │       │       └── matrix.mtx
    │       ├── h3k27me3
    │       │   └── fragmentFiles
    │       │       ├── L539_CRE3-Mice8724_rH3K27me3_rNano150.fragments.tsv.gz
    │       │       ├── L539_CRE3-Mice8724_rH3K27me3_rNano150.fragments.tsv.gz.tbi
    │       │       ├── N167_CreN-9451-6m-Epith-HV-pA-K27.fragments.tsv.gz
    │       │       ├── N167_CreN-9451-6m-Epith-HV-pA-K27.fragments.tsv.gz.tbi
    │       │       ├── N168_CreN-9603-3m-Epith-HV-pA-K27.fragments.tsv.gz
    │       │       ├── N168_CreN-9603-3m-Epith-HV-pA-K27.fragments.tsv.gz.tbi
    │       │       ├── N253_CREneg_p1234_H3K27me3.fragments.tsv.gz
    │       │       └── N253_CREneg_p1234_H3K27me3.fragments.tsv.gz.tbi
    │       ├── h3k4me1
    │       │   └── fragmentFiles
    │       │       ├── L539_CRE3-Mice8724_rH3K4me1_rNano150.fragments.tsv.gz
    │       │       ├── L539_CRE3-Mice8724_rH3K4me1_rNano150.fragments.tsv.gz.tbi
    │       │       ├── N167_CreN-9451-6m-Epith-HV-pA-K4.fragments.tsv.gz
    │       │       ├── N167_CreN-9451-6m-Epith-HV-pA-K4.fragments.tsv.gz.tbi
    │       │       ├── N168_CreN-9603-3m-Epith-HV-pA-K4.fragments.tsv.gz
    │       │       ├── N168_CreN-9603-3m-Epith-HV-pA-K4.fragments.tsv.gz.tbi
    │       │       ├── N253_CREneg_p1234_H3K4me1.fragments.tsv.gz
    │       │       └── N253_CREneg_p1234_H3K4me1.fragments.tsv.gz.tbi
    │       └── metadata
    │           ├── CREneg_exp1_3_metadata.csv
    │           └── CREneg_exp4_5_metadata.csv
    ├── transplantations
    │   └── one_cell_multiome
    │       ├── flash
    │       │   ├── 10XlikeMatrix_read
    │       │   │   ├── barcodes.tsv
    │       │   │   ├── genes.tsv
    │       │   │   └── matrix.mtx
    │       │   └── 10XlikeMatrix_umi
    │       │       ├── barcodes.tsv
    │       │       ├── genes.tsv
    │       │       └── matrix.mtx
    │       ├── fragmentFiles
    │       │   ├── N232_p1-Day0-BCP13-cell.fragments.tsv.gz
    │       │   ├── N232_p1-Day0-BCP13-cell.fragments.tsv.gz.tbi
    │       │   ├── N232_p2-Day0-BCP13-cell.fragments.tsv.gz
    │       │   ├── N232_p2-Day0-BCP13-cell.fragments.tsv.gz.tbi
    │       │   ├── N232_p2-Day0-BCP13-cell.fragments_primary.tsv.gz
    │       │   ├── N232_p2-Day0-BCP13-cell.fragments_primary.tsv.gz.tbi
    │       │   ├── N232_p3-Day0-LCP11-cell.fragments.tsv.gz
    │       │   ├── N232_p3-Day0-LCP11-cell.fragments.tsv.gz.tbi
    │       │   ├── N232_p4-Day0-HyP14-cell.fragments.tsv.gz
    │       │   ├── N232_p4-Day0-HyP14-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p11-Day0-LCP11-cell.fragments.tsv.gz
    │       │   ├── N233_p11-Day0-LCP11-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p13-Day4d5-allepithP15-cell.fragments.tsv.gz
    │       │   ├── N233_p13-Day4d5-allepithP15-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p14-Day4d5-allepithP15-cell.fragments.tsv.gz
    │       │   ├── N233_p14-Day4d5-allepithP15-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p5-Day4d5-BCHyLCP16-cell.fragments.tsv.gz
    │       │   ├── N233_p5-Day4d5-BCHyLCP16-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p7-Day4d5-BCHyP15-cell.fragments.tsv.gz
    │       │   ├── N233_p7-Day4d5-BCHyP15-cell.fragments.tsv.gz.tbi
    │       │   ├── N233_p8-Day4d5-BCHyLCP16-cell.fragments.tsv.gz
    │       │   ├── N233_p8-Day4d5-BCHyLCP16-cell.fragments.tsv.gz.tbi
    │       │   ├── N242_p10-Day0-P11LC.fragments.tsv.gz
    │       │   ├── N242_p10-Day0-P11LC.fragments.tsv.gz.tbi
    │       │   ├── N242_p12-Day0-P14Hy.fragments.tsv.gz
    │       │   ├── N242_p12-Day0-P14Hy.fragments.tsv.gz.tbi
    │       │   ├── N242_p9-Day0-BCP13.fragments.tsv.gz
    │       │   └── N242_p9-Day0-BCP13.fragments.tsv.gz.tbi
    │       └── metadata
    │           └── metadata_transplantations.csv
    └── zygotes
        ├── bigwigs
        │   ├── D1535_D1480C05_H3K27me3_bulk_r1.bw
        │   ├── D1535_D1480C06_H3K27me3_bulk_r2.bw
        │   ├── D1888T0577_Zygote_4_rH3K27me3_pA_Cell1.bw
        │   ├── D1888T0586_Zygote_4_rH3K4me1_pA_Cell5.bw
        │   ├── D1888T0593_Zygote_5_rH3K27me3_pA_Cell6.bw
        │   ├── D1888T0606_Zygote_5_rH3K4me1_pA_Cell10.bw
        │   ├── D1888_Zygotes_all_rH3K27me3_RNA_pseudobulk.bw
        │   ├── D1888_Zygotes_all_rH3K4me1_RNA_pseudobulk.bw
        │   ├── GSM7645420_H3K4me1_zygote.mm10.bw
        │   ├── GSM7645437_H3K27me3_zygote.mm10.bw
        │   ├── L548_Zygote_4_rH3K27me3_pA_Cell1.bigwig
        │   ├── L548_Zygote_4_rH3K4me1_pA_Cell5.bigwig
        │   ├── L548_Zygote_5_rH3K27me3_pA_Cell6.bigwig
        │   ├── L548_Zygote_5_rH3K4me1_pA_Cell10.bigwig
        │   ├── L548_Zygote_rH3K27me3.bigwig
        │   └── L548_Zygote_rH3K4me1.bigwig
        ├── matrices
        │   ├── bw_summary_zygotes_05mb_withRNA.tab
        └── one_cell_multiome
            ├── flash
            │   ├── 10XlikeMatrix_read
            │   │   ├── barcodes.tsv
            │   │   ├── genes.tsv
            │   │   └── matrix.mtx
            │   └── 10XlikeMatrix_umi
            │       ├── barcodes.tsv
            │       ├── genes.tsv
            │       └── matrix.mtx
            ├── h3k27me3
            │   └── fragmentFiles
            │       ├── L548_Zygote_rH3K27me3.fragments.tsv.gz
            │       └── L548_Zygote_rH3K27me3.fragments.tsv.gz.tbi
            └── h3k4me1
                └── fragmentFiles
                    ├── L548_Zygote_rH3K4me1.fragments.tsv.gz
                    └── L548_Zygote_rH3K4me1.fragments.tsv.gz.tbi

```

- Fragment files, 10Xlike matricies and bigwigs for all datasets produced in this study can be directly downloaded from GEO (**GSE290486**).
- The metadata files and the 0.5Mb signal matrix (for the zygote dataset) are available in the **metadata** folder of this repository. 
- The bigwigs for the data produced outside of this study can be generated from the raw data deposited to GEO (**GSE164409**: bulk H3K27me3 ChIp-seq for the MM468 cell line, **GSE235109** (GSM7645420  sample) - pseudobulk H3K4me1 TACIT for zygotes). 
\
\
Before running the scripts, all files should be placed to the corresponding input sub-folder and named accordingly.

## 2. Script description 
The **scripts** folder contains the following files:

```
.
├── 1.1_technique_comparison.Rmd
├── 1.2_multiome_MM468.rmd
├── 2.1_multiome_zygotes.Rmd
├── 3.1_multiome_mouse_mammary_gland_preprocessing.qmd
├── 3.2_multiome_mouse_mammary_gland_analysis.qmd
├── 4.1_multiome_transplantations_preprocessing.qmd
├── 4.2_multiome_transplantations_analysis.qmd
├── 5.1_sample_type_comparison.Rmd
├── functions.Rmd
└── global_variables.Rmd


```
EXPLANATION OF THE ORDER. 

each script will automatically create an associated sub-folders in the **output** folder to save the output images and objects. 

The *functions.Rmd* and *global_variables.Rmd* scripts contain the dependencies and common functions loading step. They are loaded in the beginnig of each script and do not have to be run expliciltly. 
\
\
The expected output of each script is available in the **notebooks** folder, which contains the rendered Markdown documents generated from each script.
\
\
The output of the scripts was used in the following figures of the article (**TO UPDATE WHEN FINAL VERSION**):
- 1.1_technique_comparison: Fig1 bc, Ext Fig2 ab
- 1.2_sample_type_comparison: Fig1 d
- 2.1_multiome_mouse_mammary_gland: Fig1 e, Fig2 bc, Ext Fig3 bcf
- 2.2_multiome_persisters: Fig1 e, Fig2 ef
- 2.3_multiome_zygotes: Fig1 e, Fig2 ghi, Ext Fig4 abc

## 3. Dependencies
The code was run in Rstudio (R version 4.4.2) on a standard laptop running under macOS Sequoia 15.2. 
\
All packages required to run the code and the software versions used are listed in *scripts
/global_variables.Rmd*. The packages should be installed before running the scripts. 
The installation time should not exceed 40 min.

## 4. Runtime
On a standard laptop (MacBook Pro M1, 16Gb RAM), the estimated runtime for all of the scripts does not exceed 1h.


