DROP TABLE IF EXISTS locations;
CREATE TABLE locations(placeName VARCHAR(64) PRIMARY KEY, geog geography(POINT) );
INSERT INTO locations (placeName, geog) VALUES ('My home', 'SRID=4326;POINT(-122.028556 37.382472)');
INSERT INTO locations (placeName, geog) VALUES ('Car Parking', 'SRID=4326;POINT(-122.030250 37.382139)');
INSERT INTO locations (placeName, geog) VALUES ('Community Entrance', 'SRID=4326;POINT(-122.029750 37.381500)');
INSERT INTO locations (placeName, geog) VALUES ('Fire Station', 'SRID=4326;POINT(-122.033028 37.381972)');
INSERT INTO locations (placeName, geog) VALUES ('Twitter', 'SRID=4326;POINT(-122.034611 37.382250)');
INSERT INTO locations (placeName, geog) VALUES ('Libbys Water Tower', 'SRID=4326;POINT(-122.035167 37.381389)');
INSERT INTO locations (placeName, geog) VALUES ('Acubed', 'SRID=4326;POINT(-122.035139 37.382694)');
INSERT INTO locations (placeName, geog) VALUES ('Wildwood Manor', 'SRID=4326;POINT(-122.032056 37.383528)');
INSERT INTO locations (placeName, geog) VALUES ('Sutton Place', 'SRID=4326;POINT(-122.031694 37.384944)');
INSERT INTO locations (placeName, geog) VALUES ('Peartree', 'SRID=4326;POINT(-122.031222 37.386000)');
INSERT INTO locations (placeName, geog) VALUES ('Murphy Park', 'SRID=4326;POINT(-122.027139 37.381306)');
INSERT INTO locations (placeName, geog) VALUES ('Caltrain Station', 'SRID=4326;POINT(-122.030694 37.378722)');

SELECT ST_AsText(ST_ConvexHull(ST_Collect(r.geog::geometry))) 	
FROM locations As r;	

SELECT placeName, geog
FROM locations
WHERE placeName<>'My home'
ORDER BY geog <-> 'SRID=4326;POINT(-122.028556 37.382472)'::geometry
LIMIT 4;