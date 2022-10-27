{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "000_airbyte_dbt_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('company_ab3') }}
select
    id,
    age,
    name,
    salary,
    address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_company_hashid
from {{ ref('company_ab3') }}
-- company from {{ source('000_airbyte_dbt_1', '_airbyte_raw_company') }}
where 1 = 1

