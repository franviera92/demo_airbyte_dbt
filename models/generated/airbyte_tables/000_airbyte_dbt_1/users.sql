{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "000_airbyte_dbt_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    id,
    city,
    email,
    image,
    phone,
    country,
    job_type,
    full_name,
    job_title,
    last_name,
    first_name_2,
    onboarding_completion,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('000_airbyte_dbt_1', '_airbyte_raw_users') }}
where 1 = 1

