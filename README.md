# Pipeline de Transformación de Datos ELT - Exchange Rates API

Este proyecto implementa un flujo de transformación de datos utilizando **dbt**, **Airbyte** y **DuckDB**. El objetivo es procesar datos crudos de tipos de cambio obtenidos vía API, normalizarlos y generar modelos analíticos agregados.

## 🚀 Arquitectura del Proyecto

El proyecto sigue una arquitectura adaptada a dbt:

1.  **Seeds**: Catálogo estático de monedas (Nombre, Símbolo).
2.  **Staging**: Limpieza de tipos de datos y desagrupación de JSON (`rates`).
3.  **Intermediate**: Agregaciones temporales (Promedios mensuales).
4.  **Marts (OBT)**: Tabla única consolidada lista para visualización.

## 📊 Linaje de Datos (DAG)

![Grafo de Dependencias](/dbt-env-tp/mi_proyecto_dbt/docs/9.line_graph.PNG)


### 🛡️ Estrategia de Calidad de Datos
Se han implementado **15 puntos de control** para asegurar que la información en la tabla final (`obt_tipo_cambio`):

1. **Tests Genéricos:** Garantizan la unicidad y completitud de los datos (`unique`, `not_null`).
2. **Tests Avanzados (dbt-expectations):****Validación de volumen:** La tabla de staging no debe estar vacía.
   * **Validación de rangos:** El tipo de cambio y promedios deben ser valores positivos coherentes.
3. **Tests Singulares (Reglas de Negocio):**  `assert_monedas_distintas`: Detecta si la moneda base es igual a la de destino.
   * `assert_tipo_cambio_positivo`: Asegura que no existan valores de tipo de cambio incoherente.

> **Nota de Gestión de Excepciones:** Se ha configurado la severidad `warn` en validaciones críticas de negocio.Esto permite que el pipeline se complete exitosamente para mantener la disponibilidad de datos, mientras se generan alertas para la investigación de anomalías detectadas en la fuente.

## 📊 Linaje de Datos (DAG) con calidad de datos

![Grafo de Dependencias](/dbt-env-tp/mi_proyecto_dbt/docs/10.tp6_line_graph_dbt_expectations.PNG)


## 🛠️ Requisitos Previos

* Python 3.10+
* Entorno virtual configurado (`venv`).
* DuckDB configurado en MotherDuck.
* Archivo de base de datos `airbyte_curso`

