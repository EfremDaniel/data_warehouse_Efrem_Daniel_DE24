-- 1. Start with a high-level role
-- Switches to the USERADMIN role, which has the authority to create roles and manage role hierarchy.
USE ROLE USERADMIN;


-- Checking what role is currently active and which user is running the commands.
SELECT CURRENT_ROLE();
SELECT CURRENT_USER();

----------------------------------------------------------------------------------

-- 2 CREATE CUSTOM ROLES

-- Creating custom roles and defining what their task is 
CREATE ROLE ice_cream_reader COMMENT = 'Able to read ice_cream database';
CREATE ROLE ice_cream_writer COMMENT 
= 'Able to CRUD operations on ice_cream database';
CREATE ROLE ice_cream_analyst COMMENT 
= 'Able to create views on ice_cream database';

----------------------------------------------------------------------------------

-- 3. SWITCH TO SECURITYADMIN (NEEDED TO GIVE PRIVILEGES)
USE ROLE SECURITYADMIN;

----------------------------------------------------------------------------------

-- 4 GRANT PERMISSIONS TO READER ROLE

-- Grants the reader the ability to use the warehouse (DEV_WH) and access the database (ice_cream_db).
GRANT USAGE ON WAREHOUSE DEV_WH TO ROLE ice_cream_reader;

-- Reader can now see/use all schemas in the database.
GRANT USAGE ON DATABASE ice_cream_db TO ROLE ice_cream_reader;

SHOW GRANTS TO ROLE ice_cream_reader;


-- Reader can now see/use all schemas in the database.
GRANT USAGE ON ALL SCHEMAS IN DATABASE ice_cream_db TO ROLE ice_cream_reader;


-- Reader can query (read) all current and future tables in the PUBLIC schema.
GRANT SELECT ON ALL TABLES IN SCHEMA ICE_CREAM_DB.PUBLIC TO ROLE ice_cream_reader;
GRANT SELECT ON FUTURE TABLES IN SCHEMA ICE_CREAM_DB.PUBLIC TO ROLE ice_cream_reader;


SHOW GRANTS TO ROLE ice_cream_reader;
SHOW FUTURE GRANTS IN SCHEMA ICE_CREAM_DB.PUBLIC;


----------------------------------------------------------------------------------


-- 5. SET UP HIERARCHY

-- Writer role inherits all reader permissions.
-- (So a writer can read + do extra things.)
GRANT ROLE ice_cream_reader TO ROLE ice_cream_writer;
SHOW GRANTS TO ROLE ice_cream_writer;


----------------------------------------------------------------------------------


-- 6. Grant extra privileges to writer
-- Allows writer role to modify existing data (Insert, Update, Delete).
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ICE_CREAM_DB.PUBLIC TO ROLE ice_cream_writer;
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA ICE_CREAM_DB.PUBLIC TO ROLE ice_cream_writer;


-- Allows writer to also create new tables
GRANT CREATE TABLE ON SCHEMA ICE_CREAM_DB.PUBLIC TO ROLE ice_cream_writer;

-- Verifying privileges.
SHOW FUTURE GRANTS IN SCHEMA ICE_CREAM_DB.PUBLIC;

-- Verifying privileges for the writer
SHOW GRANTS TO ROLE ice_cream_writer;  

-- Granting the User (Yours truly =) the same privilege as the writer
GRANT ROLE ice_cream_writer TO USER EFREMDE24;

USE ROLE ice_cream_writer;

 