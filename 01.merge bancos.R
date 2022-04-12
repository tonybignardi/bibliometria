library(bibliometrix)
library(tidyverse)

#Título contém MOOC, de 2015-2022, apenas articles


# TITLE-ABS-KEY ( "flipped classroom" )  AND 
#( LIMIT-TO ( PUBYEAR ,  2022 )  OR 
#LIMIT-TO ( PUBYEAR ,  2021 )  OR  
#LIMIT-TO ( PUBYEAR ,  2020 )  OR 
#LIMIT-TO ( PUBYEAR ,  2019 )  OR  
#LIMIT-TO ( PUBYEAR ,  2018 ) )  AND 
#( LIMIT-TO ( DOCTYPE ,  "ar" )  OR  LIMIT-TO ( DOCTYPE ,  "re" ) ) 

#https://www.webofscience.com/wos/woscc/summary/46ca0c98-f648-48af-aa99-50e3c1520045-2f1d629e/relevance/1

  df.scopus <-  convert2df("scopus_flipped.bib", 
                         dbsource = "scopus",
                         format = "bibtex")%>%
  mutate(BANCO="SCOPUS")

  df.wos1 <-  convert2df("wos_flipped1.bib", 
                      dbsource = "wos",
                      format = "bibtex")%>%
  mutate(BANCO="ISI")

  df.wos2 <-  convert2df("wos_flipped2.bib", 
                      dbsource = "wos",
                      format = "bibtex")%>%
  mutate(BANCO="ISI")

  df.wos3 <-  convert2df("wos_flipped3.bib", 
                       dbsource = "wos",
                       format = "bibtex")%>%
  mutate(BANCO="ISI")
  df.wos4 <-  convert2df("wos_flipped4.bib", 
                       dbsource = "wos",
                       format = "bibtex")%>%
  mutate(BANCO="ISI")

  
  

df.full <- mergeDbSources( df.scopus,df.wos1,df.wos2,df.wos3,df.wos4, remove.duplicated = TRUE)%>%
  select(-DB)%>%
  rename(DB = BANCO)





count(df.full%>%filter(DB=="ISI"))

saveRDS(df.full, "biblio_flipped.MOOC.rds")

