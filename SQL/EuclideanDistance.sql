/*
Consider and to be two points on a 2D plane where are the respective minimum and maximum values of Northern Latitude (LAT_N) and

are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points
and and format your answer to display decimal digits
*/

SELECT ROUND(sqrt(power((B - A),2) + power((D - C),2)),4)
FROM (
        SELECT MAX(LAT_N) AS B, MIN(LAT_N) AS A , MAX(LONG_W) AS D , MIN(LONG_W) AS C
        FROM STATION
    ) ;