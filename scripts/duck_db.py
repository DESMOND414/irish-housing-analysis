import duckdb

con = duckdb.connect("retail.duckdb")

con.execute("""
CREATE OR REPLACE TABLE online_retail AS
SELECT *
FROM read_csv_auto('data/online_retail_cleaned.csv');
""")

print("Table loaded")

