## ----settings, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
        collapse = TRUE,
        comment = "#>"
)

library("png")



## ----chargement, echo = FALSE-------------------------------------------------
library(lczexplore)

## ----import-des-fichiers, eval = TRUE, echo = TRUE----------------------------
dirPath <- system.file("extdata/multipleWfs/Redon", package = "lczexplore")
redonOSM <- importLCZvect(dirPath = dirPath, file = "osm_lcz.fgb", column = "LCZ_PRIMARY", verbose = FALSE)
redonBDT <- importLCZvect(dirPath = dirPath, file = "bdt_lcz.fgb", column = "LCZ_PRIMARY", verbose = FALSE)

## ----show, echo=FALSE, fig.dim = c(8, 6)--------------------------------------
map1<-showLCZ(sf=redonOSM, wf="OSM", column="LCZ_PRIMARY", repr="standard")

## ----show-drop, fig.dim = c(8, 6), echo = FALSE-------------------------------
map2<-showLCZ(sf=redonOSM,wf="OSM",column="LCZ_PRIMARY",repr="standard",drop=TRUE)

## ----show-alter, fig.dim = c(8, 6), eval = TRUE, echo = TRUE------------------
# Choix d'un vecteur de couleurs alternatif aléatoire
testCol <- palette.colors(n = 17, palette = "Polychrome 36")
map3 <- showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "alter", colors = testCol, useStandCol = FALSE)


## ----niveau-vide, fig.dim = c(8, 6), eval = TRUE, echo = TRUE-----------------

LCZlevels <- c(2, 3, 5, 6, 8, 9, 10, 101, 102, 104, 105, 107)
map4 <- showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "alter", LCZlevels = LCZlevels, drop = FALSE)

## ----couleurs-nommees, fig.dim = c(8, 6), eval = TRUE, echo = TRUE------------
# Choix de couleurs prises au hasard

# Après une première représentation on constate qu'il n'y a que les typeLevels 2, 3, 5, 6, 8, 9, 101, 102, 104, 105, 107.
# Je spécifie un vecteur de couleur de taille 11 colors
LCZlevels <- c(2, 3, 5, 6, 8, 9, 101, 102, 104, 105, 107)
couleurs <- c("red", "brown1", "orange", "coral", "grey", "darkgreen", "chartreuse4", "springgreen3",
              "darkolivegreen", "black", "#6d67fd")
map5 <- showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "alter", drop = TRUE, LCZlevels = LCZlevels, colors = couleurs)


## ----groupage, fig.dim = c(8, 6), eval = TRUE, echo = TRUE--------------------
redonOSMgrouped <- groupLCZ(redonOSM, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107", colors = c("red", "black", "green", "grey", "burlywood", "blue"))
map6 <- showLCZ(redonOSMgrouped, column = "grouped", repr = "alter", wf = "OSM",
                LCZlevels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
                colors = c("red", "black", "green", "grey", "burlywood", "blue"))


## ----comparaison, fig.dim = c(16,12 ), eval = TRUE, echo = FALSE--------------
path <- paste0(system.file("extdata/", package = "lczexplore"), "/redonCompare")
comparaison <- compareLCZ(sf1 = redonBDT, column1 = "LCZ_PRIMARY", wf1 = "BD TOPO v2.2",
                          sf2 = redonOSM, column2 = "LCZ_PRIMARY", wf2 = "Open Street Map", ref = 1,
                          repr = "standard", exwrite = FALSE, location = "Redon",
                          saveG = path)


## ----comparaison-image-jolie, out.width = "680px"-----------------------------
path <- system.file('extdata/redonCompare.png',package="lczexplore")
knitr::include_graphics(path, error=FALSE)


## ----cleaningpng--------------------------------------------------------------
file.remove(path)

## ----valeurs-numeriques, eval = TRUE, echo = TRUE-----------------------------
comparaison$percAgg
comparaison$pseudoK

## ----analyse-sensibilite, eval = TRUE, echo = TRUE----------------------------
dirPath <- paste0(system.file("extdata", package = "lczexplore"), "/multipleWfs/Redon")

redonOSM <- importLCZvect(dirPath = dirPath, file = "osm_lcz.fgb", column = "LCZ_PRIMARY", geomID = "ID_RSU", confid = "LCZ_UNIQUENESS_VALUE")

redonBDT <- importLCZvect(dirPath = dirPath, file = "bdt_lcz.fgb", column = "LCZ_PRIMARY", geomID = "ID_RSU", confid = "LCZ_UNIQUENESS_VALUE")

redonCompare <- compareLCZ(sf1 = redonBDT, wf1 = "bdt", geomID1 = "ID_RSU", column1 = "LCZ_PRIMARY",
                           confid1 = "LCZ_UNIQUENESS_VALUE",
                           sf2 = redonOSM, wf2 = "osm", geomID2 = "ID_RSU", column2 = "LCZ_PRIMARY", confid2 = "LCZ_UNIQUENESS_VALUE", exwrite = FALSE, plot = FALSE)


## ----comparaison-avec-confiance, echo = TRUE, fig.show="hide"-----------------
path <- system.file('extdata/redonCompare',package="lczexplore")
redonCompare <- compareLCZ(sf1 = redonBDT, wf1 = "bdt", geomID1 = "ID_RSU", column1 = "LCZ_PRIMARY",
                           confid1 = "LCZ_UNIQUENESS_VALUE",
                           sf2 = redonOSM, wf2 = "osm", geomID2 = "ID_RSU", column2 = "LCZ_PRIMARY",
                           confid2 = "LCZ_UNIQUENESS_VALUE", exwrite = FALSE, saveG = path)
# redonInputSensib<-read.csv()

## ----sortie-jolie, out.width = "680px"----------------------------------------
path <- system.file('extdata/GeneralUniquenessSensib.png',package="lczexplore")
knitr::include_graphics(path, error=FALSE)


## ----analyse-sensibilite-2, fig.dim = c(12,9), fig.show="hide"----------------
names(redonCompare$data)
confidRedon <- confidSensib(inputDf = redonCompare$data, filePath = "", nPoints = 10,
                            wf1 = "bdtopo_2_2", wf2 = "osm",
                            geomID1 = "ID_RSU", column1 = "bdt", confid1 = "LCZ_UNIQUENESS_VALUE",
                            geomID2 = "ID_RSU.1", column2 = "osm", confid2 = "LCZ_UNIQUENESS_VALUE.1",
                            sep = ";", repr = "standard",
                            plot = TRUE, saveG = system.file("extdata/", package = "lczexplore"))


## ----sortie-sensibilite-jolie, out.width = "680px"----------------------------
path <- paste0(system.file("extdata/GeneralUniquenessSensib",package="lczexplore"), ".png")
knitr::include_graphics(path, error=FALSE)


## ----sensibilite-par-type-de LCZ, out.width = "680px"-------------------------
path <- paste0(system.file("extdata/byLCZUniquenessSensib", package = "lczexplore"), ".png")
knitr::include_graphics(path, error = FALSE)


## ----cleanup------------------------------------------------------------------
path <- system.file("extdata/byLCZUniquenessSensib.png", package = "lczexplore")
if (file.exists(path)){file.remove(path)}

path <- system.file("extdata/GeneralUniquenessSensib.png", package = "lczexplore")
if (file.exists(path)){file.remove(path)}
path <- system.file("extdata/redonCompare.png", package = "lczexplore")
if (file.exists(path)){file.remove(path)}

