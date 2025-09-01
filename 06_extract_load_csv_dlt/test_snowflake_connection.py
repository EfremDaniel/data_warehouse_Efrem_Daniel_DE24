import snowflake.connector

conn = snowflake.connector.connect(
    user= "EFREMDE24",
    password= "Bethlehem2727!",
    account= "jm72079.west-europe.azure",   # OBS: utan .snowflakecomputing.com
    warehouse= "dev_wh",
    database= "Movies",
    schema= "movie_staging"   # eller ditt schema
)

cs = conn.cursor()
cs.execute("SELECT CURRENT_VERSION()")
print(cs.fetchone())
