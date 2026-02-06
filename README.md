# OneCell_CUT&Tag

This repository contains the code used for the downstream analysis and visualisation of the data from the **Schwager & Mouteaux, 2026** paper (Pubmed ID: **XXXX**).
\
Please, read the information below for the scripts description and reproducibility instructions.

## 0. Data availability
All input and annotation data required to run the scripts are deposited to Zenodo (**DOI: 10.5281/zenodo.18505452**). 
\
\
The raw sequencing data are deposited in GEO (**GSE290486**).
\
\
Public data used in this analysis were downloaded from GEO (**GSE164409**: bulk H3K27me3 ChIP-seq for the MM468 cell line, **GSE235109** (GSM7645420 sample) : H3K4me1 TACIT for zygotes).

## 1. Setup Instructions
To reproduce the analysis, the user should create the following folder structure on their local machine : 

```
.
├── annotation
├── input
├── output
└── scripts

```
The **scripts** folders should be cloned from this github repository as they are.
\
The **output** folder should be created and left empty. Its subfolders and content will be ctreated automatically while running the scripts. 
\
The **input** and **annotation** folders should be copied directly from Zenodo (**DOI: 10.5281/zenodo.18505452**) without any modification.
After a successful download, the input folder should have the following structure:

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

The scripts are organized into analysis blocks numbered 1 to 5. Each script automatically creates a corresponding subfolder within the output directory to store generated images and objects.
Some scripts depend on the outputs of others and must be executed in a specific order: script 3.2 depends on 3.1; script 4.2 depends on 3.1 and 4.1; and script 5.1 depends on 1.2, 2.1, and 3.1. 
\
\
The *functions.Rmd* and *global_variables.Rmd* scripts define shared dependencies and common utility functions. They are sourced at the beginning of each script and do not need to be executed explicitly.



The output of the scripts is used in the following **figures** of the article (**TO ADD supps**):
- 1.1_technique_comparison: **Fig 1c, Ext Fig 3b,c**
- 1.2_multiome_MM468: **Fig1 d,e, Ext Fig 3e**
- 2.1_multiome_zygotes: **Fig2 a-h, Ext Fig 5 a-c**
- 3.1_multiome_mouse_mammary_gland_preprocessing: **Ext Fig 6 c**
- 3.2_multiome_mouse_mammary_gland_analysis: **Fig3 c-d, f-l, Ext Fig 6 e-h**
- 4.1_multiome_transplantations_preprocessing: **Ext Fig 7 a**
- 4.2_multiome_transplantations_analysis: **Fig4 b-j**
- 5.1_sample_type_comparison: **Fig1 f**


\
The expected output of each script is available in the **notebooks** folder, which contains the rendered Markdown documents generated from each script.

## 3. Dependencies
The code was run in Rstudio, using R (4.5.1) and Python (v3.10.19).
\
\
R packages and software versions are listed in *scripts/global_variables.Rmd*.
Python dependencies and software versions are listed in *snap_py310_env.yml*.

Before running the scripts, the Python evironment *snap_py310_env.yml* should be created and all packages should be installed.
The installation time should not exceed 60 min.

## 4. Runtime
On a standard laptop, the runtime for all of the scripts does not exceed 2h (MacBook Pro M4, 128Gb RAM) or 4h (MacBook Pro M1, 16Gb RAM).

