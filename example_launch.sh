#!/bin/bash
source ~/.research_config

#############
# INPUT FILES
#############
# i) multimodal metadata file
multimodal_metadata_fp=$LOCAL_GASPERINI_2019_DATA_DIR"at-scale/processed/multimodal/multimodal_metadata.rds"
# ii) gene ODM
gene_odm_fp=$LOCAL_GASPERINI_2019_DATA_DIR"at-scale/processed/gene/gasp_scale_gene_expressions.odm"
# iii) gRNA ODM
gRNA_odm_fp=$LOCAL_GASPERINI_2019_DATA_DIR"at-scale/processed/gRNA_ungrouped/gasp_scale_gRNA_counts_ungrouped.odm"
# iv) gene-gRNA group pairs
pair_fp=$LOCAL_GASPERINI_2019_DATA_DIR"at-scale/processed/multimodal/pairs.rds"

##############
# OUTPUT FILE:
##############
result_fp=$PWD"/sceptre_result.rds"

###############
# OPTIONAL ARGS
###############
formula="~gene_p_mito+gene_batch+log(gene_n_nonzero)+log(gene_n_umis)+log(gRNA_n_nonzero)+log(gRNA_n_umis)"
# threshold, B, side, gene_pod_size, gRNA_group_pod_size, pair_pod_size

########################
# invoke the NF pipeline
########################
nextflow main.nf \
 --multimodal_metadata_fp $multimodal_metadata_fp \
 --gene_odm_fp $gene_odm_fp \
 --gRNA_odm_fp $gRNA_odm_fp \
 --pair_fp $pair_fp \
 --result_fp $result_fp \
 --formula $formula \
 --gene_pod_size 5 \
 --gRNA_group_pod_size 5 \
 --pair_pod_size 10 \
 -resume
