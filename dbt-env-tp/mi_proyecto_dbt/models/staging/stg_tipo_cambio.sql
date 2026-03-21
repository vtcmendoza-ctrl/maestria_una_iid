with source as (
    select * from {{ source('api_tipo_cambio', 'exchange_rates') }}
),

-- 1. Extraer las llaves del JSON (son las monedas) 
x as (
    select
        "date",
        base,
        unnest(json_keys(rates)) as moneda_destino,
        rates
    from source
)

-- 2. Extraer el valor numérico del JSON
select
    cast("date" as date) as fecha_cotizacion,
    cast(base as varchar(3)) as moneda_base,
    cast(moneda_destino as varchar(3)) as moneda_destino,
    -- Concatenar '$.' con el nombre de la moneda para extraer el tipo de cambio
    cast(json_extract_string(rates, '$.' || moneda_destino) as decimal(18, 6)) as tipo_cambio
from x