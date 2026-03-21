with source as (
    select * from {{ source('api_tipo_cambio', 'exchange_rates') }}
),

-- EExtraer dato de la llave
llaves_ as (
    select unnest(json_keys(rates)) as codigo_moneda
    from source
),

monedas_unicas as (

-- Regisro unico por moneda
select distinct
    cast(codigo_moneda as varchar(3)) as codigo_moneda
from llaves_
where codigo_moneda is not null
), 

--Archivo con simbolo de monedas
csv_moneda as (
    select * from {{ ref('ref_monedas') }}
),

resultado as (
    select
        m.codigo_moneda,
        coalesce(d.nombre_moneda, 'n/a') as desc_moneda,
        d.simbolo_moneda
    from monedas_unicas m
    left join csv_moneda d on m.codigo_moneda = d.codigo_moneda
)

select * from resultado