## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
        collapse = TRUE,
        comment = "#>"
)

## ----load, eval = TRUE, echo = TRUE-------------------------------------------
library(lczexplore)

## ----import, eval = TRUE, echo = TRUE-----------------------------------------
redonBbox<-importLCZvect(dirPath=paste0(system.file("extdata", package = "lczexplore"),
"/multipleWfs/Redon"), file="osm_lcz.fgb",column="LCZ_PRIMARY",output="bBox")


# Example with osmdata function getbb, not run, to avoid installation of the package
# library(osmdata)
# redonBbox<-getbb("Redon", format_out = "sf_polygon")

## ----import-raster, eval = TRUE, echo = TRUE----------------------------------
redonWudapt<-importLCZraster(system.file("extdata", package = "lczexplore"),
fileName="redonWudapt.tif", bBox=redonBbox)


## ----import-sf-for-CRS, eval = TRUE, echo = TRUE------------------------------
library(sf)
st_crs(redonWudapt)

## ----summaries, fig.dim = c(8, 6), eval = TRUE, echo = TRUE-------------------
summary(redonWudapt)
summary(redonWudapt$EU_LCZ_map)

## ----show, fig.dim = c(8, 6), eval = TRUE, echo = TRUE------------------------
map1<-showLCZ(sf = redonWudapt,column = 'EU_LCZ_map', repr= "standard")

## ----import-OSM, eval = TRUE, echo = TRUE-------------------------------------
# Path to OSM data specifically
dirPathOSM<-system.file("extdata/multipleWfs/Redon",package="lczexplore")
# loading Redon Data produced with GeoClimate on OSM input Data
redonOSM<-importLCZvect(dirPath=dirPathOSM,file="osm_lcz.fgb",column = "LCZ_PRIMARY", drop=TRUE)
summary(redonOSM$LCZ_PRIMARY)


## ----show-standard, fig.dim = c(8, 6), echo = TRUE----------------------------
map2<-showLCZ(sf = redonOSM, repr="standard")


## ----compare osm wudapt, echo = TRUE, fig.show="hide", eval = TRUE------------
summary(redonOSM)
summary(redonWudapt)
compareLCZ(sf1 = redonWudapt, column1 = "EU_LCZ_map", wf1="WUDAPT",
           sf2 = redonOSM, column2 = "LCZ_PRIMARY", wf2 = "GeoClimate_OSM",
           ref=1 ,exwrite=FALSE,saveG = "comparisonR" )

## ----prettier-graph, out.width = "680px"--------------------------------------

knitr::include_graphics("comparisonR.png", error=FALSE)


## ----grouping, echo=TRUE, fig.show="hide"-------------------------------------

# Regroup levels of the WUDAPT sf file.
redonWudaptGrouped<-groupLCZ(redonWudapt,column="EU_LCZ_map",
                              urban=c("1","2","3","4","5","6","7","8","9"),
                              industry="10", vegetation=c("101","102","103","104"),
                              impervious="105",pervious="106",water="107", outCol = "Regrouped")

# Regroup levels of the GeoClimate sf file
redonOSMgrouped<-groupLCZ(redonOSM, column="LCZ_PRIMARY",
urban=c("1","2","3","4","5","6","7","8","9"),
industry="10", vegetation=c("101","102","103","104"),
impervious="105",pervious="106",water="107", outCol = "Regrouped")


# Pass the files, the columsn and a vector of colors associated to the broader categories

compareLCZ(sf1 = redonWudaptGrouped, column1 = "Regrouped", wf1 = "Wudapt",
           sf2 = redonOSMgrouped, column2 = "Regrouped", wf2 = " GeoClimate on OSM data",
           exwrite = FALSE, plot=TRUE, repr="alter", levels=c("urban","industry","vegetation","impervious","pervious","water"),colors=c("red","black","green","grey","burlywood","blue"), saveG="comparisonGroupedR")



## ----show-grouped-prettier, out.width = "680px"-------------------------------

knitr::include_graphics("comparisonGroupedR.png", error=FALSE)


## ----cleanup------------------------------------------------------------------
if (file.exists("comparisonGroupedR.png")){file.remove("comparisonGroupedR.png")}

