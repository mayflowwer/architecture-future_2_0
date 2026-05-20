---
title: "DWH на базе Microsoft SQL Server 2008"
ring: hold
quadrant: platforms-and-operations
tags: [dwh, database, legacy]
---

Microsoft SQL Server 2008 используется как основа DWH. 
Версия снята с поддержки Microsoft в 2019 году, что создаёт 
риски безопасности и ограничивает возможности масштабирования. 
Рекомендуется миграция на современное колоночное хранилище 
(ClickHouse, MinIO + Iceberg) в рамках трансформации data-платформы.