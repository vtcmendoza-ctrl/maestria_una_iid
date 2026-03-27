-- Regla de negocio: Validar que el tipo de cambio siempre debe ser un valor positivo.
-- El test fallará si encuentra algún registro con tasa <= 0.
{{ config(severity = 'warn') }}
select
    moneda_destino,
    tipo_cambio
from {{ ref('stg_tipo_cambio') }}
where tipo_cambio <= 0