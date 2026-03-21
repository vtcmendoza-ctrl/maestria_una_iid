# Pipeline de Transformación de Datos ELT - Exchange Rates API

Este proyecto implementa un flujo de transformación de datos utilizando **dbt**, **Airbyte** y **DuckDB**. El objetivo es procesar datos crudos de tipos de cambio obtenidos vía API, normalizarlos y generar modelos analíticos agregados.

## 🚀 Arquitectura del Proyecto

El proyecto sigue una arquitectura adaptada a dbt:

1.  **Seeds**: Catálogo estático de monedas (Nombre, Símbolo).
2.  **Staging**: Limpieza de tipos de datos y desagrupación de JSON (`rates`).
3.  **Intermediate**: Agregaciones temporales (Promedios mensuales).
4.  **Marts (OBT)**: Tabla única consolidada lista para visualización.

## 📊 Linaje de Datos (DAG)

![Grafo de Dependencias](9.line_graph.PNG)

## 🛠️ Requisitos Previos

* Python 3.10+
* Entorno virtual configurado (`venv`).
* DuckDB configurado en MotherDuck.
* Archivo de base de datos `airbyte_curso`

