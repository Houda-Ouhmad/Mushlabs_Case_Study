
# Unnest the json country dimensions data returned from WHO Data
SELECT

  JSON_VALUE(dimension_values, '$.Code') AS Code,
  JSON_QUERY(dimension_values, '$.Title') AS Title,
  JSON_VALUE(dimension_values, '$.Dimension') AS Dimension,
  JSON_VALUE(dimension_values, '$.ParentDimension') AS Parent_Dimension,
  JSON_QUERY(dimension_values, '$.ParentCode') AS Parent_Code,
  JSON_VALUE(dimension_values, '$.ParentTitle') AS Parent_Title

FROM {{source('core','raw_gho_countries')}}
, UNNEST (JSON_QUERY_ARRAY(value,'$.')) AS dimension_values
