with tipo_cambio as (
    select * from {{ ref('stg_tipo_cambio') }}
),

calculo as (
    select
        moneda_base,
        moneda_destino,
        date_trunc('month', fecha_cotizacion) as mes_cotizacion,
        avg(tipo_cambio) as tc_promedio,
        max(tipo_cambio) as tc_maxima,
        min(tipo_cambio) as tc_minima, 
        now() as ingresado_at
    from tipo_cambio
    group by 1, 2, 3
)

select * from calculo