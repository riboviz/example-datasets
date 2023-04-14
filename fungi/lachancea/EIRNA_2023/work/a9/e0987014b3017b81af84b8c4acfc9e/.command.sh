#!/bin/bash -ue
umi_tools extract -I LK_S3_L001_R1_001_init10000_trim.fq             --bc-pattern="^(?P<umi_1>.{4}).+(?P<umi_2>.{5})(?P<cell_1>.{5})$"             --extract-method=regex -S LK_S3_L001_R1_001_init10000_extract_trim.fq
