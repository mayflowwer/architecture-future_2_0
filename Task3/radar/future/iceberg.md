---
title: "Apache Iceberg + Nessie"
ring: trial
quadrant: tools
tags: [data-lake, metadata, table-format]
---

Apache Iceberg используется как табличный формат для data lake 
поверх MinIO. Обеспечивает ACID-транзакции, эволюцию схем 
и партиционирование без перезаписи данных. Nessie выступает 
каталогом Iceberg-таблиц — хранит указатели на актуальные 
метаданные и обеспечивает Git-подобное версионирование таблиц.