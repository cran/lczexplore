## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----import-LCZ-files, echo = TRUE, eval = TRUE-------------------------------
library(lczexplore)


dirPath <- system.file("extdata/multipleWfs/Redon", package = "lczexplore")
redonOSM <- importLCZvect(dirPath = dirPath, file = "osm_lcz.fgb", column = "LCZ_PRIMARY")
redonBDT <- importLCZvect(dirPath = dirPath, file = "bdt_lcz.fgb", column = "LCZ_PRIMARY")
#

## ----comparison, fig.dim = c(8, 6), echo = TRUE, eval = TRUE------------------

comparison <- compareLCZ(sf1 = redonBDT, column1 = "LCZ_PRIMARY", wf1 = "BD TOPO v2.2",
                         sf2 = redonOSM, column2 = "LCZ_PRIMARY", wf2 = "Open Street Map", ref = 1,
                         repr = "standard", exwrite = FALSE, location = "Redon", saveG = "")
comparison$pseudoK

## ----grouping, fig.dim = c(8, 6), echo = TRUE, eval = TRUE--------------------
redonOSMgrouped <- groupLCZ(redonOSM, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107",
                            colors = c("red", "black", "green", "grey", "burlywood", "blue"))

levCol(sf = redonOSMgrouped, column = "grouped", LCZlevels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
       colors = c("red", "black", "green", "grey", "burlywood", "blue"))

map1 <- showLCZ(redonOSMgrouped, column = "grouped", repr = "alter", wf = "OSM",
                LCZlevels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
                colors = c("red", "black", "green", "grey", "burlywood", "blue"))

## ----common-grouping-case, fig.dim = c(8, 6), echo = TRUE, eval = TRUE--------

redonBDTgrouped <- groupLCZ(redonBDT, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107",
                            colors = c("red", "black", "green", "grey", "burlywood", "blue"))

map1.1 <- showLCZ(redonBDTgrouped, column = "grouped", repr = "alter", wf = "OSM",
                LCZlevels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
                colors = c("red", "black", "green", "grey", "burlywood", "blue"))

comparisonGrouped <- compareLCZ(sf1 = redonOSMgrouped, column1 = "grouped", wf1 = "osmGpd",
                                sf2 = redonBDTgrouped, column2 = "grouped", wf2 = "bdtGpd",
                                repr = "alter",
                                levels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
                                colors = c("red", "black", "green", "grey", "burlywood", "blue"))

## ----no-color-specified, fig.dim = c(8, 6), echo = TRUE, eval = TRUE----------
levCol(sf=redonOSMgrouped,column="grouped",
       levels=c("urban","industry","vegetation","impervious","pervious","water"))

redonGroupedCompare<-compareLCZ(sf1 = redonOSMgrouped, column1 = "grouped",
           sf2 = redonBDTgrouped, column2 = "grouped",
           repr = "alter",
           levels = c("urban", "industry", "vegetation", "impervious", "pervious", "water")
)

## ----colors-but-no-levels, fig.dim = c(8, 6), eval = TRUE, echo = TRUE--------
utrfRedonBDT <- importQualVar(dirPath = paste0(
  system.file("extdata", package = "lczexplore"), "/utrfFiles"),
                              file = "bdt_utrf_area.fgb", column = "TYPO_MAJ")
summary(utrfRedonBDT)
summary(utrfRedonBDT$TYPO_MAJ)

map3 <- showLCZ(sf = utrfRedonBDT, column = "TYPO_MAJ", repr = "alter",
                title = " UTRF classification of the French city of Redon",
                colors = c("red", "black", "green", "grey", "burlywood", "blue", "orange", "lightgreen", "brown"))

## ----these-are-not-colors, echo = TRUE, eval = TRUE---------------------------
levCol(sf = utrfRedonBDT, column = "TYPO_MAJ",
       colors = c("red", "black", "green", "grey", "burlywood", "blue", "orange", "lightgreen", "brown"))

levCol(sf = utrfRedonBDT, column = "TYPO_MAJ",
       colors = c("red", "black", "green", "grey", "burlywood", "blue", "orange", "lightgreen", "NOT_COLOR"))

## ----some-data-uncovered, echo = TRUE, eval = TRUE----------------------------
levCol(sf = redonOSMgrouped, column = "grouped",
       levels = c("urban", "industry", "vegetation", "impervious", "pervious"),
       colors = c("red", "black", "green", "grey", "burlywood")
)


## ----not-enough-colors, echo = TRUE, eval = TRUE------------------------------
levCol(sf = redonOSMgrouped, column = "grouped",
       levels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
       colors = c("red", "black", "green", "grey", "burlywood")
)


## ----another-case, echo = TRUE, eval = TRUE-----------------------------------
levCol(sf = redonOSMgrouped, column = "grouped",
       levels = c("urban", "industry", "vegetation", "impervious", "pervious"),
       colors = c("red", "black", "green", "grey", "burlywood", "blue")
)

## ----group-and-compare-on the fly, fig.dim = c(8, 6), echo = TRUE, eval = TRUE----

map4 <- showLCZ(sf = redonBDT, column = "LCZ_PRIMARY", repr = "alter",
                urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                industry = "10",
                vegetation = c("101", "102", "103", "104"),
                impervious = "105", pervious = "106", water = "107",
                colors = c("red", "black", "green", "grey", "burlywood", "blue"), tryGroup = TRUE)


compareLCZ(sf1 = redonBDT, column1 = "LCZ_PRIMARY",
           sf2 = redonOSM, column2 = "LCZ_PRIMARY",
           repr = "alter", ref = 2, saveG = "", exwrite = FALSE, location = "Redon", plot = TRUE,
           urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
           industry = "10",
           vegetation = c("101", "102", "103", "104"),
           impervious = "105", pervious = "106", water = "107",
           colors = c("red", "black", "green", "grey", "burlywood", "blue"), tryGroup = TRUE)

