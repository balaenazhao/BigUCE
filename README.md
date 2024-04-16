# BigUCE

Code used in the study **_Building large-scale phylogenies using independent datasets: a draft Avian Tree of Life_**

## **Assess Clade Monophyly**
We evaluated clade monophyly for pre-defined groups (e.g., superordinal clades, orders, families and genera) using the AssessMonophyly function in R package **MonoPhy** (Schwery and O’Meara 2016). Tutorial of MonoPhy can be found at https://rdrr.io/cran/MonoPhy/man/AssessMonophyly.html. We generally assumed that a tree estimation method was more reliable when it recovered a larger number of these groups as monophyletic.

## **Calculate Tree Distances**
We used the **ete3** toolkit (Huerta-Cepas et al. 2016) to calculate pairwise normalized Robinson Foulds distances between our trees. Tutorial for ete3 can be found at http://etetoolkit.org/documentation/ete-compare/. Pairwise tree distances were then transformed to a NEXUS distance block using the write.nexus.dist function in **phangorn** (Schliep 2011). With this data block, we used __PAUP*__ 4 (Swofford and Sullivan 2009) to infer a neighbor joining (NJ) “tree-of-trees” to show distribution of trees in tree space.

## **Visualization**
This folder contains the R scripts and associated data that were used to plot the figures in the main text and supplementary information. PDF outputs from R were modified using **Inkscape**, a free vector graphics editor (https://inkscape.org/).
