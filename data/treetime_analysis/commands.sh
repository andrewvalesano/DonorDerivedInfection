mkdir data/iqtree_output
iqtree -redo -nt 2 -ninit 10 -me 0.05 -bb 1000 -wbtl -czb -m GTR --prefix data/iqtree_output/michigan_timetree -s data/meta_mi_ddi.fasta -o Wuhan/WH01/2019
treetime --tree data/iqtree_output/michigan_timetree.treefile --dates data/meta_mi_ddi.tsv --aln data/meta_mi_ddi.fasta --outdir data/treetime_output --confidence --keep-polytomies  --clock-filter 0 --clock-rate 0.0008 --clock-std-dev 0.0004 --coalescent skyline
treetime ancestral --aln data/meta_mi_ddi.fasta --tree data/iqtree_output/michigan_timetree.treefile --outdir data/ancestral_output
