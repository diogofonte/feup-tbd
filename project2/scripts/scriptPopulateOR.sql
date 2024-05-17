--Populate dw Regions
insert into dw_regions (region_id, region_name)
select region_id, region_name
from dbo_regions;

--Populate dw Countries
INSERT INTO dw_countries (country_id, country_name, region)
SELECT
    c.country_id,
    c.country_name,
    (SELECT REF(r) FROM dw_regions r WHERE r.region_id = c.region_id) 
FROM
    dbo_countries c;

--Populate dw Locations
INSERT INTO dw_locations (location_id, street_address, postal_code, city, state_province, country)
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    l.state_province,
    (SELECT REF(c) FROM dw_countries c WHERE c.country_id = l.country_id) 
FROM
    dbo_locations l;