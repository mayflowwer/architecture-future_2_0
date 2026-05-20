---
title: "dbt (Data Build Tool)"
ring: trial
quadrant: tools
tags: [etl, transformation, data-platform, analytics]
---

dbt используется как слой SQL-трансформаций поверх data lake.
Преобразует сырые данные (raw) из MinIO в аналитические витрины (marts)
через версионированные SQL-модели. Содержит всю бизнес-логику
трансформаций — DWH остаётся хранилищем без логики.
Запускается по расписанию через Apache Airflow.
Публикует lineage и метаданные моделей в DataHub. Self-hosted.
