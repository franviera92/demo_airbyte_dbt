{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "000_airbyte_dbt_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('bookings_ab3') }}
select
    id,
    user_id,
    booked_at,
    confirmed,
    starts_at,
    booked_for,
    apartment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_bookings_hashid
from {{ ref('bookings_ab3') }}
-- bookings from {{ source('000_airbyte_dbt_1', '_airbyte_raw_bookings') }}
where 1 = 1

