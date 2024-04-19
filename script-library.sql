-- Created by: dexterroberts
-- Date Created: 4/19/24
-- Last Modified: 4/19/24
-- Description: A library of spatial SQL scripts tailored for GIS data analysis.

-- Select areas where the statefp (Wisconsin) is equal to '55'
SELECT * FROM cb_2019_us_county_500k
WHERE statefp = '55'