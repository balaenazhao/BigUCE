# BigUCE

Code used in the study 
> Efficient Inference of Macrophylogenies: Insights from the Avian Tree of Life

## **Authors**
Min Zhao, Gregory Thom, Brant C. Faircloth, Michael J. Andersen, F. Keith Barker, Brett W. Benz, Michael J. Braun, Gustavo A. Bravo, Robb T. Brumfield, R. Terry Chesser, Elizabeth P. Derryberry, Travis C. Glenn, Michael G. Harvey, Peter A. Hosner, Tyler S. Imfeld, Leo Joseph, Joseph D. Manthey, John E. McCormack, Jenna M. McCullough, Robert G. Moyle, Carl H. Oliveros, Noor D. White Carreiro, Kevin Winker, Daniel J. Field, Daniel T. Ksepka, Edward L. Braun, Rebecca T. Kimball, Brian Tilston Smith

## **Phylogenomic Data Processing**
Scripts for performing the three-step filtering process to obtain 27 filtered datasets. We also calculated individual-based summary statistics to evaluate data heterogeneity across datasets from different studies.

## **Supertree Estimation**
The supertree approach and the divide-and-conquer approach both included a supertree estimation component via matrix representation with parsimony (MRP). We provided the scripts to build the MRP tree matrices and the source trees for various supertree analyses.

## **Assess Clade Monophyly**
We evaluated clade monophyly for pre-defined groups (e.g., superordinal clades, orders, families and genera) using the AssessMonophyly function in R package **MonoPhy** (Schwery and O’Meara 2016). Tutorial of MonoPhy can be found at https://rdrr.io/cran/MonoPhy/man/AssessMonophyly.html. We generally assumed that a tree estimation method was more reliable when it recovered a larger number of these groups as monophyletic.

## **Calculate Tree Distances**
We used the **ete3** toolkit (Huerta-Cepas et al. 2016) to calculate pairwise normalized Robinson Foulds distances between our trees. Tutorial for ete3 can be found at http://etetoolkit.org/documentation/ete-compare/. Pairwise tree distances were then transformed to a NEXUS distance block using the write.nexus.dist function in **phangorn** (Schliep 2011). With this data block, we used __PAUP*__ 4 (Swofford and Sullivan 2009) to infer a neighbor joining (NJ) “tree-of-trees” to show distribution of trees in tree space.

## **Divergence Time Estimation**
We used penalized likelihood to estimate divergence time for seven trees in **TreePL** (Smith and O'Meara 2012). We applied a total of 43 fossil calibrations. Individual configuration file and parameter settings can be found in this folder.

## **Visualization**
This folder contains the R scripts and associated data that were used to plot the figures in the main text and supplementary information. PDF outputs from R were modified using **Inkscape**, a free vector graphics editor (https://inkscape.org/).
