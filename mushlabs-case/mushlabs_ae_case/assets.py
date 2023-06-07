import pandas as pd
from dagster import asset
from dagster_dbt import load_assets_from_dbt_project

from .resources import DBT_PROFILE_DIR, DBT_PROJECT_DIR, IGHOODataResource

dbt_assets = load_assets_from_dbt_project(
    project_dir=DBT_PROJECT_DIR,
    profiles_dir=DBT_PROFILE_DIR,
)


@asset(key_prefix=["core"], compute_kind="pandas")
def raw_gho_gender_inequality(
    gho: IGHOODataResource,
) -> pd.DataFrame:
    # Replace `endpoint` with the actual endpoint to fetch gender inequality data from the GHO API
    endpoint = "CCO_3" # Indicator code for gender inequality
    data = gho.make_api_call(endpoint)
    # Process the fetched data as needed
    df = pd.DataFrame(data)  # Convert the data to a DataFrame or perform any required transformations
    print(df)     #Test
    return df


@asset(key_prefix=["core"], compute_kind="pandas")
def raw_gho_countries(
    gho: IGHOODataResource,
) -> pd.DataFrame:
    # Replace `endpoint` with the actual endpoint to fetch country data from the GHO API
    endpoint = "DIMENSION/COUNTRY/DimensionValues"
    data = gho.make_api_call(endpoint)
    # Process the fetched data as needed
    df = pd.DataFrame(data)  # Convert the data to a DataFrame or perform any required transformations
    print(df)       #Test
    return df
