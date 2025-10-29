library(sf)
library(tidyverse)

kcr <- read_csv("data/kc_house_data.csv")
kcs <- sf::read_sf("data/School_Districts_in_King_County___schdst_area.geojson") |> select(district=NAME)

kcr_sf <-kcr |> st_as_sf(coords = c("long", "lat"), crs=st_crs(kcs)) 

kcf_sf_nf <- kcr_sf |> st_join(kcs, join=st_nearest_feature) |> 
    st_drop_geometry()

kcf_sf_nf |> write_csv("data/kc_house_data.csv")