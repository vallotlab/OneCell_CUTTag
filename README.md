# OneCell_CUT&Tag

This repository contains the code used for the downstream analysis and visualisation of the data from the **Mouteaux & Schwager, 2025** paper (pubmed ID: XXXX).
\
Please, read the information below for the scripts description and reproducibility instructions.

## 0. Data availability
All raw and processed files produced in this study can be downloaded from GEO (XXXXXX). 
Additional annotation and metadata files are present in this repository in the **annotation** and **metadata** folders.
Public data used in this analysis (FGO H3K27AC STAR-ChIP-seq dataset) were downloaded from GEO (GSE217970).

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
│   │   │   ├── auto
│   │   │   │   └── h3k27me3
│   │   │   │       └── fragmentFiles
│   │   │   │           ├── L536_MM468_H3K27me3_pA150.fragments.tsv.gz
│   │   │   │           └── L536_MM468_H3K27me3_pA150.fragments.tsv.gz.tbi
│   │   │   └── manual
│   │   │       └── h3k27me3
│   │   │           └── fragmentFiles
│   │   │               ├── L497_L551_MM468_rH3K27me3.fragments.tsv.gz
│   │   │               └── L497_L551_MM468_rH3K27me3.fragments.tsv.gz.tbi
│   │   ├── one_cell_multiome
│   │   │   ├── flash
│   │   │   │   └── 10XlikeMatrix_umi
│   │   │   │       ├── barcodes.tsv
│   │   │   │       ├── genes.tsv
│   │   │   │       └── matrix.mtx
│   │   │   └── h3k27me3
│   │   │       └── fragmentFiles
│   │   │           ├── L537_MM468_rH3K27me3_rNano150.fragments.tsv.gz
│   │   │           └── L537_MM468_rH3K27me3_rNano150.fragments.tsv.gz.tbi
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
│   ├── fresh_PDX
│   │   └── one_cell_multiome
│   │       ├── flash
│   │       │   └── 10XlikeMatrix_umi
│   │       │       ├── barcodes.tsv
│   │       │       ├── genes.tsv
│   │       │       └── matrix.mtx
│   │       └── h3k4me1
│   │           └── fragmentFiles
│   │               ├── L547_Persister-BC152_rH3K4me1.fragments.tsv.gz
│   │               ├── L547_Persister-BC152_rH3K4me1.fragments.tsv.gz.tbi
│   │               ├── L547_Untreated-BC152_rH3K4me1.fragments.tsv.gz
│   │               └── L547_Untreated-BC152_rH3K4me1.fragments.tsv.gz.tbi
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
    │   ├── bigwigs
    │   │   ├── D1888_CRE3-Mice8724_T0290_basal_cell.bw
    │   │   ├── D1888_CRE3-Mice8724_T0302_luminal_cell.bw
    │   │   ├── D1888_CRE3-Mice8724_all_rna_pseudobulk.bw
    │   │   ├── D1888_CRE3-Mice8724_cluster_0_rna_basal.bw
    │   │   ├── D1888_CRE3-Mice8724_cluster_1_rna_luminal.bw
    │   │   ├── D1888_CRE3-Mice8724_h3k27me3_pseudobulk_rna.bw
    │   │   └── D1888_CRE3-Mice8724_h3k4me1_pseudobulk_rna.bw
    │   └── one_cell_multiome
    │       ├── facs
    │       │   └── MultiOme_FACSdata_l539.csv
    │       ├── flash
    │       │   └── 10XlikeMatrix_umi
    │       │       ├── barcodes.tsv
    │       │       ├── genes.tsv
    │       │       └── matrix.mtx
    │       ├── h3k27me3
    │       │   └── fragmentFiles
    │       │       ├── L539_CRE3-Mice8724_rH3K27me3_rNano150.fragments.tsv.gz
    │       │       └── L539_CRE3-Mice8724_rH3K27me3_rNano150.fragments.tsv.gz.tbi
    │       └── h3k4me1
    │           └── fragmentFiles
    │               ├── L539_CRE3-Mice8724_rH3K4me1_rNano150.fragments.tsv.gz
    │               └── L539_CRE3-Mice8724_rH3K4me1_rNano150.fragments.tsv.gz.tbi
    └── zygotes
        ├── bigwigs
        │   ├── D1535_D1480C05_cutran_zygotes_H3K27me3.bw
        │   ├── D1888T0590_Zygote_5_cell3_RNA.bw
        │   ├── D1888_Zygote_5_pseudobulk_RNA.bw
        │   └── SRR22286444_starrchip_FGO_H3K27Ac.bw
        ├── matrix_500kb
        │   └── bw_summary_zygotes_k27me3_bulk_and_sc_oocyte_k27ac_bulk0.5Mb.tab
        └── one_cell_multiome
            ├── flash
            │   └── 10XlikeMatrix_umi
            │       ├── barcodes.tsv
            │       ├── genes.tsv
            │       └── matrix.mtx
            └── h3k27me3
                └── fragmentFiles
                    ├── L548_Zygote_4_rH3K27me3_pA.fragments.tsv.gz
                    ├── L548_Zygote_4_rH3K27me3_pA.fragments.tsv.gz.tbi
                    ├── L548_Zygote_5_rH3K27me3_pA.fragments.tsv.gz
                    └── L548_Zygote_5_rH3K27me3_pA.fragments.tsv.gz.tbi
```

All input files (fragmentFiles, 10Xlike matricies and bigwigs) produced in this study can be downloaded from GEO (XXXXX). 
\
The CPM-normalized bigwig file for the STARR-ChIP H3K27Ac full grown oocyte dataset was generated from the raw fastq files downloaded from SRA (SRX18260532).
\
The facs data (for the mouse mammary gland dataset) and and 500kb signal matrix (for the zygote dataset) are available in the **metadat*a* folder of this repository. 
\
Before running the scripts, the files should be placed to the corresponding input sub-folder and named accordingly.

## 2. Dependencies
The code was run in Rstudio (R version 4.4.2) on a standard laptop running under macOS Sequoia 15.2. 
\
All packages required to run the code and the software versions used are listed in *scripts
/global_variables.Rmd* and should be installed before running the scripts. 

## 3. Script description 
The **scripts* folder contains the following files:
```
.
├── 1.1_technique_comparison.Rmd
├── 1.2_sample_type_comparison.Rmd
├── 2.1_multiome_mm468.Rmd
├── 2.2_multiome_mouse_mammary_gland.Rmd
├── 2.2_multiome_zygotes.Rmd
├── functions.Rmd
└── global_variables.Rmd

```
The scripts are organised per analysis and can be run independently from each other. Each script will create an associated sub-folders in the *output* folder to save the output images and objects.
\
The *functions.Rmd* and *global_variables.Rmd* scripts contain the dependencies and common functions loading step. They are loaded in the beginnig of each script and do not have to be run expliciltly. 
\
Expected output of each of the scripts can be seen in the html files in the *scripts* folder.

## 4. Runtime
On a standard laptop (MacBook Pro M1, 16Gb RAM), the estimated runtime for all of the scripts does not exceed 1h.


