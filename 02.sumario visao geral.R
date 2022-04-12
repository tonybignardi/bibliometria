library(tidyverse)
library(bibliometrix)

#Título contém MOOC, de 2015-2022, apenas articles

# carregar os bibtext
df.full <- readRDS("biblio_flipped.MOOC.rds")

info <- biblioAnalysis(df.full)
summary(info)
plot(info)


