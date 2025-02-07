# OneCell_CUT&Tag

## 1. Setup Instructions - folder structure

To reproduce the analysis from the Mouteaux & Schwager 2025 paper, the user should create the following folder structure on their local machine : 

```
.
├── annotation
├── input
├── output
└── scripts

```
The **input** folder should have the following sub-directories:

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
│   │   │   ├── h3k27me3
│   │   │   │   └── fragmentFiles
│   │   │   │       ├── L537_MM468_rH3K27me3_rNano150.fragments.tsv.gz
│   │   │   │       └── L537_MM468_rH3K27me3_rNano150.fragments.tsv.gz.tbi
│   │   │   └── h3k4me1
│   │   │       └── fragmentFiles
│   │   │           ├── L537_MM468_rH3K4me1_pA150.fragments.tsv.gz
│   │   │           └── L537_MM468_rH3K4me1_pA150.fragments.tsv.gz.tbi
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
│   │       ├── facs
│   │       │   └── MultiOme_FACSannotation_l547.csv
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

All input files can be downloaded from GEO (XXXXX). They should be placed to the corresponding input sub-folder and named accordingly. 
/
The scripts and annotation folders should be cloned from this github repository as they are.
/
The sub-folders of the output directory will be created automatically when running the scripts.



## 2. Dependencies

## 3. Script description
