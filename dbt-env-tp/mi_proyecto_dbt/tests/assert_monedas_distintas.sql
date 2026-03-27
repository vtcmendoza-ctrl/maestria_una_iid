-- Regla de negocio: Validar que la moneda de origen no sea igual a la de destino.
-- El test fallará si encuentra filas donde coincidan.
{{ config(severity = 'warn') }}
select
    moneda_base,
    moneda_destino,
    fecha_cotizacion
from {{ ref('stg_tipo_cambio') }}
where moneda_base = moneda_destino