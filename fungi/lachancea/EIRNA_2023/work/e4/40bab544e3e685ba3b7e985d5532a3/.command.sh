#!/bin/bash -ue
python -m riboviz.tools.trim_5p_mismatch -m 2             -i orf_map.sam -o orf_map_clean.sam -s trim_5p_mismatch.tsv
