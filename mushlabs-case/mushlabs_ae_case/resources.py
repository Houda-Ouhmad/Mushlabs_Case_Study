import os
from abc import abstractmethod
from typing import Optional

import requests
from dagster import ConfigurableResource, get_dagster_logger
from dagster_dbt import DbtCliClientResource
from dagster_duckdb_pandas import DuckDBPandasIOManager
from pydantic import Field

# get path from root because the dbt cli is a little buggy with relative paths
FILE_PATH = os.path.dirname(os.path.abspath(__file__))

DBT_PROJECT_DIR = os.path.join(FILE_PATH, "dbt_project")
DBT_PROFILE_DIR = os.path.join(DBT_PROJECT_DIR, "profiles")

logger = get_dagster_logger()

duckdb_io_manager = DuckDBPandasIOManager(
    database=os.path.join(FILE_PATH, "..", "dbt_duckdb.db")
)


class IGHOODataResource(ConfigurableResource):
    @abstractmethod
    def make_api_call(self, *args, **kwargs) -> dict:
        raise NotImplementedError()


class GHOODataResource(IGHOODataResource):
    base_url: str = Field(
        "https://ghoapi.azureedge.net/api/", description="GHO API base url"
    )

    def make_api_call(
        self,
        endpoint: str,
        params: Optional[dict] = None,
        headers: Optional[dict] = None,
    ) -> dict:
        # Build the full URL for the API call
        url = self.base_url + endpoint

        # Make the API call using requests library
        response = requests.get(url, params=params, headers=headers)

        # Check if the request was successful
        if response.status_code == 200:
            return response.json()

        # Handle error cases if the request fails
        raise Exception(f"Failed to make API call to {endpoint}. Error: {response.text}")


resource_def = {
    "LOCAL": {
        "io_manager": duckdb_io_manager,
        "gho": GHOODataResource.configure_at_launch(),
        "dbt": DbtCliClientResource(
            project_dir=DBT_PROJECT_DIR,
            profiles_dir=DBT_PROFILE_DIR,
            target="local",
        ),
    },
}
