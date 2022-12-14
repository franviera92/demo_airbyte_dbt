{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "000_airbyte_dbt_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('config_item_ab3') }}
select
    propertykey,
    propertyvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_config_item_hashid
from {{ ref('config_item_ab3') }}
-- config_item from {{ source('000_airbyte_dbt_1', '_airbyte_raw_config_item') }}
where 1 = 1

