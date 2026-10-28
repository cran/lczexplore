## ----settings, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  out.width="100%"
)


## ----loadAllLocsAllWfs--------------------------------------------------------
require(lczexplore)
twoLocsDir<-paste0(
  system.file("extdata", package = "lczexplore"),"/multipleWfs")
twoLocsSfList<-importMultipleLocsLCZvect(dirPath = twoLocsDir, workflowNames = c("osm","bdt","wudapt"),
                                   location = c("Arville", "Redon"))

## ----Intersect----------------------------------------------------------------
twoLocsSfIntersected <- createIntersect(sfList = twoLocsSfList, columns = rep("lcz_primary", 4),
                                        refCrs=NULL, workflowNames=c("osm", "bdt", "wudapt"), minZeroArea=0.000)

## ----showLCZ, fig.width=8, fig.height=5---------------------------------------
showLCZ(sf = twoLocsSfList$Redon$osm, column = "lcz_primary", repr = "standard")

## ----compareLCZ, fig.width=16, fig.height=10----------------------------------
redonOSM <- twoLocsSfList$Redon$osm
redonBDT <- twoLocsSfList$Redon$bdt
compareLCZ(sf1 = redonOSM, sf2 = redonBDT, column1 = "lcz_primary", column2 = "lcz_primary", wf1 = "osm", wf2 = "bdt_V_2")

## ----barplotLCZfromIntersected, fig.width=8, fig.height=5---------------------
areaPerLCZtype<-barplotLCZfromIntersect(sfIn = twoLocsSfIntersected, workflowNames = c("osm", "bdt", "wudapt"))

## ----multiple-comparison------------------------------------------------------
twoLocsCompared <- compareMultipleLCZ(
  sfInt = twoLocsSfIntersected,
  columns = c("osm","bdt","wudapt"),
  trimPerc = 0)

## ----multiple-pairwise-agreement----------------------------------------------
twoLocsCompared$agreements

## ----multiple-confusion-matrix------------------------------------------------
twoLocsFlow<-createWeightedFlux(twoLocsSfIntersected, wfNamesIn = c("osm","bdt","wudapt"))

## ----chord-diagram, fig.width=16, fig.height=10-------------------------------
drawChordDiagram(weightedFluxIn = twoLocsFlow)

## ----load-concat-complete-----------------------------------------------------
twoLocsDir<-paste0(
  system.file("extdata", package = "lczexplore"),"/multipleWfs")

# allWfsAllLocs<-importConcatMultipleLocsLCZvect(twoLocsDir, locations = NA, workflowNames = c("osm", "bdt", "wudapt"),
#                                        missingGeomsWf= "osm", refWf = NULL, refLCZ = NA,
#                                        residualLCZvalue = NA, column = "lcz_primary")

