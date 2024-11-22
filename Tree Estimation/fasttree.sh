#!/bin/sh

# initial analysis on AMNH HPC
iqtree2  -s *.phylip -nt 32 -fast -m GTR+G -mem 96G
