-- Created by: dexterroberts
-- Date Created: 4/19/24
-- Last Modified: 4/19/24
-- Description: A library of spatial SQL scripts tailored for GIS data analysis.

-- Select counties where the statefp (Wisconsin) is equal to '55'
SELECT * FROM cb_2019_us_county_500k
WHERE statefp = '55'

-- Turning polygons into centroids
SELECT id, st_centroid(geom) AS geom
FROM cb_2018_us_county_500k
WHERE statefp = '55'