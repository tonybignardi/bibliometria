library(tidyverse)
library(bibliometrix)

#Título contém MOOC, de 2015-2022, apenas articles

# carregar os bibtext
df.full <- readRDS("biblio_flipped.MOOC.rds")

df.full %>%
  group_by(DB) %>%
  count()

dfsco <- df.full%>% filter(DB=="SCOPUS")


autores.mais.produtivos <- authorProdOverTime(df.full, 20)
