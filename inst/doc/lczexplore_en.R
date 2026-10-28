## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
        collapse = TRUE,
        comment = "#>"
)

## ----load, eval = TRUE, echo = TRUE-------------------------------------------
library(ggplot2)
library(lczexplore)

## ----load-files, eval = TRUE, echo = TRUE-------------------------------------
dirPath <- system.file("extdata/multipleWfs/Redon", package = "lczexplore")
redonOSM <- importLCZvect(dirPath = dirPath, file = "osm_lcz.fgb", column = "LCZ_PRIMARY")
redonBDT <- importLCZvect(dirPath = dirPath, file = "bdt_lcz.fgb", column = "LCZ_PRIMARY")
#

## ----show, fig.dim = c(8, 6), eval = TRUE, echo = TRUE------------------------
showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "standard", LCZlevels = "", colors = "")

## ----show-with-drop, fig.dim = c(8, 6), echo = FALSE, eval = TRUE-------------
showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "standard", drop = TRUE)

## ----show-alter-drop, fig.dim = c(8, 6),  eval = TRUE, echo = TRUE------------
# Choice of random colors from a palette
testCol <- palette.colors(n = 17, palette = "Polychrome 36")
showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "alter", colors = testCol, useStandCol = FALSE, drop = TRUE)


## ----show-chosen-colors, fig.dim = c(8, 6), eval = TRUE, echo = TRUE----------

LCZlevels <- c(2, 3, 5, 6, 8, 9, 101, 102, 104, 105, 107)
couleurs <- c("red", "brown1", "orange", "coral", "grey", "darkgreen", "chartreuse4", "springgreen3",
              "darkolivegreen", "black", "#6d67fd")
showLCZ(sf = redonOSM, wf = "OSM", column = "LCZ_PRIMARY", repr = "alter", drop = TRUE, LCZlevels = LCZlevels, colors = couleurs)


## ----group-and-show, fig.dim = c(8, 6), eval = TRUE, echo = TRUE--------------
redonOSMgrouped <- groupLCZ(redonOSM, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107", colors = c("red", "black", "green", "grey", "burlywood", "blue"))
showLCZ(redonOSMgrouped, column = "grouped", repr = "alter", wf = "OSM",
        LCZlevels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
        colors = c("red", "black", "green", "grey", "burlywood", "blue"))


## ----compare, fig.dim = c(12,9 ), echo = TRUE, fig.show="hide"----------------

path <- system.file('extdata/redonCompare',package="lczexplore")
redonCompare <- compareLCZ(sf1 = redonBDT, wf1 = "bdt", geomID1 = "ID_RSU", column1 = "LCZ_PRIMARY",
                           confid1 = "LCZ_UNIQUENESS_VALUE",
                           sf2 = redonOSM, wf2 = "osm", geomID2 = "ID_RSU", column2 = "LCZ_PRIMARY",
                           confid2 = "LCZ_UNIQUENESS_VALUE", exwrite = FALSE, saveG = path)

## ----import-compare-plot-prettier, out.width = "680px"------------------------

path <- system.file('extdata/GeneralUniquenessSensib.png',package="lczexplore")
knitr::include_graphics(path, error=FALSE)


## ----compare-grouped, echo = TRUE, fig.show="hide"----------------------------
redonOSMgrouped <- groupLCZ(redonOSM, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107", colors = c("red", "black", "green", "grey", "burlywood", "blue"))
redonBDTgrouped <- groupLCZ(redonBDT, column = "LCZ_PRIMARY",
                            urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                            industry = "10",
                            vegetation = c("101", "102", "103", "104"),
                            impervious = "105", pervious = "106", water = "107", colors = c("red", "black", "green", "grey", "burlywood", "blue"))
path <- paste0(system.file("extdata/", package = "lczexplore"), "/groupedComparison")
comparisonGrouped <- compareLCZ(sf1 = redonOSMgrouped, column1 = "grouped",
                                sf2 = redonBDTgrouped, column2 = "grouped",
                                repr = "alter",
                                levels = c("urban", "industry", "vegetation", "impervious", "pervious", "water"),
                                colors = c("red", "black", "green", "grey", "burlywood", "blue"), saveG = path)

## ----compare-grouped-plot-prettier, out.width = "680px"-----------------------
path <- paste0(system.file("extdata/", package = "lczexplore"), "/groupedComparison.png")
knitr::include_graphics(path, error=FALSE)


## ----compare-on-the-fly, out.width="70%", echo = TRUE, fig.show="hide"--------
comparisonGrouped <- compareLCZ(sf1 = redonBDT, column1 = "LCZ_PRIMARY", wf1 = "groupedBDT",
                                sf2 = redonOSM, column2 = "LCZ_PRIMARY", wf2 = "groupedOSM",
                                repr = "alter", ref = 2, saveG = "", exwrite = FALSE, location = "Redon", plot = TRUE,
                                urban = c("1", "2", "3", "4", "5", "6", "7", "8", "9"),
                                industry = "10",
                                vegetation = c("101", "102", "103", "104"),
                                impervious = "105", pervious = "106", water = "107",
                                colors = c("red", "black", "green", "grey", "burlywood", "blue"), tryGroup = TRUE)



## ----values-------------------------------------------------------------------
comparisonGrouped$percAgg
comparisonGrouped$areas

## ----compare-for-sensitivity--------------------------------------------------
dirPath <- system.file("extdata/multipleWfs/Redon", package = "lczexplore")

redonOSM <- importLCZvect(dirPath = dirPath, file = "osm_lcz.fgb", column = "LCZ_PRIMARY", geomID = "ID_RSU", confid = "LCZ_UNIQUENESS_VALUE")

redonBDT <- importLCZvect(dirPath = dirPath, file = "bdt_lcz.fgb", column = "LCZ_PRIMARY", geomID = "ID_RSU", confid = "LCZ_UNIQUENESS_VALUE")

redonCompare <- compareLCZ(sf1 = redonBDT, wf1 = "bdt", geomID1 = "ID_RSU", column1 = "LCZ_PRIMARY",
                           confid1 = "LCZ_UNIQUENESS_VALUE",
                           sf2 = redonOSM, wf2 = "osm", geomID2 = "ID_RSU", column2 = "LCZ_PRIMARY", confid2 = "LCZ_UNIQUENESS_VALUE",
                           exwrite = FALSE, plot = FALSE)

## ----perform-sensitivity, fig.show="hide"-------------------------------------
names(redonCompare$data)
confidRedon <- confidSensib(inputDf = redonCompare$data, filePath = "", nPoints = 10,
                            wf1 = "bdtopo_2_2", wf2 = "osm",
                            geomID1 = "ID_RSU", column1 = "bdt", confid1 = "LCZ_UNIQUENESS_VALUE",
                            geomID2 = "ID_RSU.1", column2 = "osm", confid2 = "LCZ_UNIQUENESS_VALUE.1",
                            sep = ";", repr = "standard",
                            plot = TRUE, saveG = system.file("extdata/", package = "lczexplore"))


## ----show-sensitivity-prettier, out.width = "680px"---------------------------
path <- paste0(system.file("extdata/GeneralUniquenessSensib",package="lczexplore"), ".png")
knitr::include_graphics(path, error=FALSE)

## ----cleaningpng--------------------------------------------------------------
file.remove(path)

## ----sensitivity-by-LCZ-type, out.width = "680px"-----------------------------

knitr::include_graphics("byLCZUniquenessSensib.png", error=FALSE)


## ----cleanup------------------------------------------------------------------
if (file.exists("byLCZUniquenessSensib.png")){file.remove("byLCZUniquenessSensib.png")}
if (file.exists("GeneralUniquenessSensib.png")){file.remove("GeneralUniquenessSensib.png")}
if (file.exists("comparison.png")){file.remove("comparison.png")}


