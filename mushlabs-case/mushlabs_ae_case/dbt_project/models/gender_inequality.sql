# Unnest the json gender inequality data returned from WHO Data
SELECT

  JSON_VALUE(gender_inequality, '$.Id') AS Id,
  JSON_QUERY(gender_inequality, '$.IndicatorCode') AS Indicator_Code,
  JSON_VALUE(gender_inequality, '$.SpatialDimType') AS Spatial_Dim_Type,
  JSON_VALUE(gender_inequality, '$.SpatialDim') AS Spatial_Dim,
  JSON_QUERY(gender_inequality, '$.TimeDimType') AS Time_Dim_Type,
  JSON_VALUE(gender_inequality, '$.TimeDim') AS Time_Dim,
  JSON_VALUE(gender_inequality, '$.Dim1Type') AS Dim1_Type,
  JSON_QUERY(gender_inequality, '$.Dim1') AS Dim1,
  JSON_VALUE(gender_inequality, '$.Dim2Type') AS Dim2_Type,
  JSON_VALUE(gender_inequality, '$.Dim2') AS Dim2,
  JSON_QUERY(gender_inequality, '$.Dim3Type') AS Dim3_Type,
  JSON_VALUE(gender_inequality, '$.Dim3') AS Dim3,
  JSON_VALUE(gender_inequality, '$.DataSourceDimType') AS Data_Source_Dim_Type,
  JSON_QUERY(gender_inequality, '$.DataSourceDim') AS Data_Source_Dim,
  JSON_VALUE(gender_inequality, '$.Value') AS Value,
  JSON_QUERY(gender_inequality, '$.NumericValue') AS Numeric_Value,
  JSON_VALUE(gender_inequality, '$.Low') AS Low,
  JSON_VALUE(gender_inequality, '$.High') AS High,
  JSON_QUERY(gender_inequality, '$.Comments') AS Comments,
  JSON_VALUE(TIMESTAMP(gender_inequality, '$.Date')) AS Date,
  JSON_VALUE(gender_inequality, '$.TimeDimensionValue') AS Time_Dimension_Value,
  JSON_QUERY(TIMESTAMP(gender_inequality, '$.TimeDimensionBegin')) AS Time_Dimension_Begin,
  JSON_VALUE(TIMESTAMP(gender_inequality, '$.TimeDimensionEnd')) AS Time_Dimension_End,

FROM {{source('core','raw_gho_gender_inequality')}}
, UNNEST (JSON_QUERY_ARRAY(value,'$.')) AS gender_inequality
