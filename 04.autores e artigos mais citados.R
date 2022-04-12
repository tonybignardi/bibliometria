library(tidyverse)
library(bibliometrix)

#Título contém MOOC, de 2015-2022, apenas articles

# carregar os bibtext
df.full <- readRDS("biblio_flipped.MOOC.rds")

artigos.wos <- as.data.frame(citations(df.full%>%filter(DB=="ISI"), "article")$Cited)

#Confiram se as citações da Scopus estão ok. Neste caso, não estão: os registros 11 a 13 são iguais
artigos.scopus <- as.data.frame(citations(df.full%>%filter(DB=="SCOPUS"), "article")$Cited)


autores.wos <- as.data.frame(citations(df.full%>%filter(DB=="ISI"), "author")$Cited)

autores.scopus <- as.data.frame(citations(df.full%>%filter(DB=="SCOPUS"), "author")$Cited)
