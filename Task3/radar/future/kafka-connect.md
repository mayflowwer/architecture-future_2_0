---
title: "Kafka Connect"
ring: trial
quadrant: tools
tags: [eda, data-platform, dwh, integration]
---

Kafka Connect используется как коннектор между Kafka и MinIO (S3).
S3 Sink Connector читает canonical-топики и записывает данные
в MinIO в формате Parquet без написания кода.
Обеспечивает надёжную загрузку событийных данных в DWH
с поддержкой exactly-once семантики. Self-hosted.
