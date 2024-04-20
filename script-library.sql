-- Created by: dexterroberts
-- Date Created: 4/19/24
-- Last Modified: 4/19/24
-- Description: A library of spatial SQL scripts and commands tailored for GIS data analysis, data management and processing.

-- Select counties where the statefp (Wisconsin) is equal to '55'
SELECT * FROM cb_2019_us_county_500k
WHERE statefp = '55'

-- Turning polygons into centroids
SELECT id, st_centroid(geom) AS geom
FROM cb_2018_us_county_500k
WHERE statefp = '55'

-- Create and name a view in QGIS
CREATE OR REPLACE view wi_centroids AS
SELECT id, st_centroid(geom) AS geom
FROM cb_2018_us_county_500k
WHERE statefp = '55'

-- Joining tables without a geometry
SELECT pc.geom, pc.postal_code,
COUNT(customers.customer_id)
FROM postal_codes pc
JOIN customers USING (postal_code)
GROUP BY pc.postal_code

-- Return spatial reference data in PostGIS / QGIS
SELECT * FROM spatial_ref_sys WHERE srid = 4326

-- Add a new projection to QGIS (step 1: go to https://epsg.io or https://epsg.io/104726)
INSERT INTO
spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext)
VALUES
(
104726,
'ESRI',
104726,
'+proj=longlat +a=6378418.941 +rf=298.257222100883 +no_defs +type=crs',
'GEOGCS["GCS_NAD_1983_HARN_Adj_MN_Hennepin",DATUM["D_NAD_1983_HARN_Adj_MN_Hennepin",
SPHEROID["S_GRS_1980_Adj_MN_Hennepin",6378418.941,298.257222100883,AUTHORITY["ESRI","107726"]],
AUTHORITY["ESRI","106726"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],
UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["ESRI","104726"]]'
);

-- Loading data with ogr2ogr
ogr2ogr \
-f PostgreSQL PG:"host=localhost port=25432 user=docker password=docker \
dbname=gis" /Users/matt/Documents/spatial-sql-book/nyc_taxi_yellow_0616-07.parquet \
-nln nyc_taxi_yellow_0616-lco GEOMETRY_NAME=geom

    -- explained:
-- ogr2ogr \ -- -f is the file type flag and PostgreSQL is the file type we are transforming to
-- -f PostgreSQL PG:"host=localhost port=25432 user=docker password=docker \ -- Details about our database
-- dbname=gis" /Users/matt/Documents/spatial-sql-book/nyc_taxi_yellow_0616-07.parquet \ -- Absolute path to our file (yours will be different)
-- nln nyc_taxi_yellow_0616 Flag for "new layer name" or the name of the table we will create
-- lco GEOMETRY_NAME=geom -- Layer creation option to add the data type GEOMETRY in a column called geom