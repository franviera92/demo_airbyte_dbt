{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "000_airbyte_dbt_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('appartments_ab3') }}
select
    id,
    city,
    name,
    image,
    booked,
    address,
    country,
    address2,
    latitude,
    zip_code,
    direction,
    longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_appartments_hashid
from {{ ref('appartments_ab3') }}
-- appartments from {{ source('000_airbyte_dbt_1', '_airbyte_raw_appartments') }}
where 1 = 1

