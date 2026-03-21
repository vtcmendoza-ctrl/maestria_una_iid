with dim_tc_mensual as (
    select * from {{ ref('int_tipo_cambio_mensual') }}
),

dim_moneda as (
    select * from {{ ref('stg_monedas') }}
),

resultado as (
    select
        m.mes_cotizacion,
        m.moneda_base,
        m.moneda_destino,
        d.desc_moneda,
        d.simbolo_moneda,
        m.tc_promedio,
        m.tc_maxima,
        m.tc_minima, 
        now() as ingresado_at
    from dim_tc_mensual m
    left join dim_moneda d on m.moneda_destino = d.codigo_moneda
)

select * from resultado