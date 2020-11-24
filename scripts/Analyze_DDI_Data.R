
### Author: Andrew Valesano
### Purpose: Analyze genomes from putative donor-derived infection of SARS-CoV-2

# ====================== Modules and data ======================

library(tidyverse)
library(ggtree)
library(treeio)

meta <- read.csv("data/metadata/ddi_metadata_final.csv", stringsAsFactors = FALSE)
coverage <- read.csv("data/raw/coverage.csv", stringsAsFactors = FALSE)

# =========================== Plot coverage ==============================

cov.plot <- ggplot(coverage, aes(x = pos, y = cov)) +
  theme_bw() +
  theme(strip.background = element_rect(colour = "white", fill = "white"),
        strip.text.x = element_text(colour = "black", face = "bold")) +
  xlab("Position") +
  ylab("Read Depth") +
  geom_line() +
  facet_wrap(~ID) +
  scale_y_log10()

# ========================= Plot a tree ===============================

tree <- read.nexus("data/treetime_analysis/results/ancestral_output/annotated_tree.nexus")
tree.plot <- ggtree(tree, layout = "circular")
tree.rect.plot <- ggtree(tree)

meta_mi_ddi <- read.table("../meta_mi_recent.tsv", sep = "\t", fill = TRUE, stringsAsFactors = FALSE, header = TRUE) # Cannot upload this file per GISAID rules
meta_mi_ddi <- mutate(meta_mi_ddi, group = ifelse(strain %in% meta$strain, "DDI Case", Nextstrain_clade))
meta_mi_ddi <- mutate(meta_mi_ddi, group_div = ifelse(strain %in% meta$strain, "DDI Case", division))

colors_main <- c("#989C97", "#00B2A9", "#FFCB05", "#2F65A7", "#D86018", "purple", "pink", "red")
tree.plot.meta <- tree.plot %<+% meta_mi_ddi +
  geom_tree(aes(color = group)) +
  scale_color_manual(name = "clade", values = colors_main) +
  theme(legend.position = "right")

tree.rect.plot.meta <- tree.rect.plot %<+% meta_mi_ddi +
  geom_tree(aes(color = group)) +
  scale_color_manual(name = "clade", values = colors_main) +
  theme(legend.position = "right")

colors_div <- c("#00B2A9", "#D86018", "#FFCB05", "#989C97", "#2F65A7", "#655A52", "#A5A508", "#702082")
tree.plot.meta.div <- tree.plot %<+% meta_mi_ddi +
  geom_tree(aes(color = group_div)) +
  scale_color_manual(name = "division", values = colors_div) +
  theme(legend.position = "right")

# Finding nodes to select
tree.rect.plot.meta + geom_text2(aes(subset=!isTip, label=node), hjust=-.3)

# Subtree
tree.subset <- tree_subset(tree, node = 216, levels_back = 0)
tree.subset.plot <- ggtree(tree.subset)
colors_zoom <- c("#D86018", "#00B2A9")
tree.subset.plot.meta <- tree.subset.plot %<+% meta_mi_ddi +
  geom_tippoint(aes(color = Nextstrain_clade), size = 3) +
  scale_color_manual(name = "nextstrain clade", values = colors_zoom) +
  theme(legend.position = "none") +
  geom_rootedge(rootedge = 0.00005) +
  geom_tiplab(size = 4, offset = -0.0004)
tree.subset.plot.meta
