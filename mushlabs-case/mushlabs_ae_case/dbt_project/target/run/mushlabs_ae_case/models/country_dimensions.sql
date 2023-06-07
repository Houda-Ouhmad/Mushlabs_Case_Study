
  create view "dbt_duckdb"."core"."country_dimensions__dbt_tmp" as (
    SELECT *
FROM "dbt_duckdb"."core"."raw_gho_countries"
  );
