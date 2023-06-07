
  create view "dbt_duckdb"."core"."gender_inequality__dbt_tmp" as (
    SELECT *
FROM "dbt_duckdb"."core"."raw_gho_gender_inequality"
  );
