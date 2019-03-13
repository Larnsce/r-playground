# Header
# 2019-03-12
# MIT Licence
# Lars Schoebitz

# Comment

# This script contains code from Chapter 2 of the Geocomputation in R book.
# https://geocompr.robinlovelace.net/spatial-class.html

# libraries

library(sf)          # classes and functions for vector data
library(raster)      # classes and functions for raster data
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data
library(tidyverse)

# learn about i

vignette(package = "sf") 
vignette("sf1")

# exploring

names(world)

class(world)

world$geom

# plot function

plot(world)

# summarising

summary(world["lifeExp"])

world %>% 
    select(lifeExp) %>% 
    summary()

# subsetting

world_mini <- world[1:2, 1:3]

world_mini

world %>% 
    slice(1:2) %>% 
    select(1:3)  

## basic map making

plot(world[3:6])
plot(world["pop"])

world %>% 
    select(pop) %>% 
    plot()

# adding plots as layers --------------------------

world[world$continent == "Asia", ]

world_asia <- world %>% 
    filter(continent == "Asia")

asia <- st_union(world_asia)

## from book

plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")

## tidyverse version

world %>% 
    select(pop) %>% 
    plot(reset = FALSE)

asia %>% 
    plot(add = TRUE, col = "red")

world %>% 
    st_union() %>% 
    plot()
    
asia %>% 
    plot(add = TRUE, col = "red")

# base plot arguments --------------------

world %>% 
    select(continent) %>% 
    plot(reset = FALSE)

cex <-  sqrt(world$pop) / 10000

world_cents <- world %>% 
    st_centroid(of_largest = TRUE)

# does not work
world_cents %>% 
    st_geometry(add = TRUE, cex = cex) %>% 
    plot()

# works
plot(st_geometry(world_cents), add = TRUE, cex = cex)

# see https://github.com/Robinlovelace/geocompr/blob/master/code/02-contpop.R
world_proj = st_transform(world, "+proj=eck4")
world_cents = st_centroid(world_proj, of_largest_polygon = TRUE)
par(mar = c(0, 0, 0, 0))
# plot(st_geometry(world), graticule = TRUE, reset = FALSE)
plot(world_proj["continent"], reset = FALSE, main = "", key.pos = NULL)
g = st_graticule()
g = st_transform(g, crs = "+proj=eck4")
plot(g$geometry, add = TRUE, col = "lightgrey")
cex = sqrt(world$pop) / 10000
plot(st_geometry(world_cents), add = TRUE, cex = cex, lwd = 2, graticule = T)

india <- world %>% 
    filter(name_long == "India")

india %>% 
    st_geometry() %>% 
    plot(expandBB = c(0, 0.5, 0.1, 1), col = "gray", lwd = 3)

plot(world_asia[0], add = TRUE)

plot(world_asia)

# 2.2.5 Geometry types

# nothing to code here.

# 2.2.6 Simple feature geometries (sfg)

st_point(c(5, 2))                   # XY Point

st_point(c(5, 2 ,3))                # XYZ Point

st_point(c(5, 2, 1), dim = "XYM")   # XYM Point

st_point(c(5, 2, 3, 1))             # XYZM Point

# the rbind function simplifies the creation of matrices

## MULTIPOINT
multipoint_matrix <- rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)

## LINESTRING
linestring_matrix <- rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)

## POLYGON
st_polygon(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))))

## POLYGON with a hole
polygon_border = rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole = rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list = list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)

## plotting

plot(st_polygon(polygon_with_hole_list))
plot(st_polygon(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))))
plot(st_linestring(linestring_matrix))
plot(st_point(c(5, 2)))

plot(st_point(c(5, 2 ,3)))
plot(st_point(c(5, 2, 1), dim = "XYM"))
plot(st_multipoint(multipoint_matrix))

# 2.2.7 Simple feature columns (sfc) --------------

# sfc POINT

p1 <- st_point(c(4, 2))
p2 <- st_point(c(1, 3))

points_sfc <- st_sfc(p1, p2)
points_sfc

plot(points_sfc)

# sfc POLYGON
## polygons are lists!

polygon_list1 <- list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 <- st_polygon(polygon_list1)
plot(polygon1)

polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)
plot(polygon2)

polygon_sfc <- st_sfc(polygon1, polygon2)
plot(polygon_sfc)

st_geometry_type(polygon_sfc)

# sfc MULTILINESTRING
multilinestring_list1 = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                             rbind(c(1, 2), c(2, 4)))
multilinestring1 = st_multilinestring((multilinestring_list1))
multilinestring_list2 = list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                             rbind(c(1, 7), c(3, 8)))
multilinestring2 = st_multilinestring((multilinestring_list2))
multilinestring_sfc = st_sfc(multilinestring1, multilinestring2)
st_geometry_type(multilinestring_sfc)

plot(multilinestring_sfc)

# sfc GEOMETRY
point_multilinestring_sfc = st_sfc(p1, multilinestring1)
st_geometry_type(point_multilinestring_sfc)
plot(point_multilinestring_sfc)

# coordinate reference system (CRS)

st_crs(points_sfc)

points_sfc_wgs <- st_sfc(p1, p2, crs = 4326)
st_crs(points_sfc_wgs)

st_sfc(p1, p2, crs = "+proj=longlat +datum=WGS84 +no_defs")

plot(points_sfc_wgs)

# 2.2.8 The sf class

class(points_sfc_wgs)

lnd_point <- st_point(c(0.1, 51.5))
lnd_geom <- st_sfc(lnd_point, crs = 4326)

lnd_attrib <- tibble(
    name = "London",
    temperature = 25,
    date = as.Date("2017-06-21")
)

lnd_sf <- st_sf(lnd_attrib, geometry = lnd_geom)

lnd_sf

class(lnd_sf)
