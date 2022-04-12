library(tidyverse)
library(bibliometrix)
library(reshape2)
library(ggplot2)

#Título contém MOOC, de 2015-2022, apenas articles

# carregar os bibtext
df.full <- readRDS("biblio_flipped.MOOC.rds")

# % de NA em PALAVRAS-CHAVE E ID
DE.vazias <- round(sum(is.na(df.full$DE))/nrow(df.full),3)
ID.vazias <- round(sum(is.na(df.full$ID))/nrow(df.full),3)

# % de NA em PALAVRAS-CHAVE E ID SCOPUS
DE.vazias.scopus <- round(sum(is.na(df.full %>% filter(DB == "SCOPUS") %>% select(DE)))/nrow(df.full),3)
ID.vazias.scopus <- round(sum(is.na(df.full %>% filter(DB == "SCOPUS") %>% select(ID)))/nrow(df.full),3)

# % de NA em PALAVRAS-CHAVE E ID
DE.vazias.wos <- round(sum(is.na(df.full %>% filter(DB == "ISI") %>% select(DE)))/nrow(df.full),3)

ID.vazias.wos <- round(sum(is.na(df.full %>% filter(DB == "ISI") %>% select(ID)))/nrow(df.full),3)


# REMOVE TERMOS DA COLUNA DE 
df.full <- df.full %>%
  mutate(DE.KW = gsub("FLIPPING","FLIPPED", DE, ignore.case = TRUE),
         DE.KW = gsub("STUDENTS","", DE, ignore.case = TRUE),
         DE.KW = gsub("STUDENT","", DE, ignore.case = TRUE),
         DE.KW = gsub("STUDY","", DE, ignore.case = TRUE),
         DE.KW = gsub("FLIPPED","", DE, ignore.case = TRUE),
         DE.KW = gsub("CLASSROOM","", DE, ignore.case = TRUE),
         DE.KW = gsub("FLIPPED CLASSROOM","", DE, ignore.case = TRUE))



view(df.full$DE)
view(df.full$DE.KW)

remover <- c("flipped classroom","de","la","en","students","student","flipped",
             "classroom","study")

# CRIA COLUNAS TI_TM E AB_TM COM TERMOS EXTRAIDOS DO TI E AB REMOVENDO remover
df.full <- termExtraction(df.full, Field = "TI", remove.terms = remover)
df.full <- termExtraction(df.full, Field = "AB", remove.terms = remover)


view(df.full$TI_TM)
view(df.full$AB_TM)


#EXEMPLOS DE TERMOS EXTRAIDOS 
df.full$AB_TM[1]
df.full$TI_TM[1]
df.full$DE[1]

# CRIA NOVO DF COM COLUNO DE AGRUPAMNDO TUDO DE.KW TI_TM E AB_TM
df.matriz <- df.full %>%
  mutate(TERMOS = paste(DE.KW, TI_TM, AB_TM, ";"))%>%
  select(-TI_TM, -AB_TM, -DE)%>%
  rename(DE = TERMOS)
  
# EXEMPLO COM UMA UNICA COLUNA DE AGRUPANDO TERMSEXTRACTION
df.matriz$DE[1]

# CRIA VARIAVEL NO FORMATO PARA O GGPLOT
topKW <- KeywordGrowth(df.matriz, Tag = "DE", sep = ";", top = 30, cdf = TRUE)
names(topKW)

df.keywords <- melt(topKW, id='Year')

ggplot(df.keywords,aes(Year,value, group=variable, color=variable))+geom_line()

#short = TRUE considera termos com pelo menos 2 ocorências
NetMatrix <- biblioNetwork(df.matriz, analysis = "co-occurrences", 
                           network = "author_keywords",sep = ";",short=TRUE)

networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Cooccurrences",
                type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)

thematicMap(
  df.matriz,
  field = "DE",
  n = 250,
  minfreq = 5,
  stemming = FALSE,
  size = 0.5,
  n.labels = 1,
  repel = TRUE
)
