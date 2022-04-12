library(tidyverse)
library(bibliometrix)

#Título contém MOOC, de 2015-2022, apenas articles

# carregar os bibtext
df.full <- readRDS("biblio_flipped.MOOC.rds")

artigos.mais.citados <- as.data.frame(citations(df.full%>%filter(DB=="ISI"), "article")$Cited)

#Confiram se as citações da Scopus estão ok. Neste caso, não estão: os registros 11 a 13 são iguais
temp <- as.data.frame(citations(df.full%>%filter(DB=="SCOPUS"), "article")$Cited)
temp$CR
artigos.mais.citados$CR 
temp$CR[11:13] # Mesmo artigo, mas não foi contado como igual por erros de registro
