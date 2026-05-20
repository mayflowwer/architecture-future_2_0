---
title: "Schema Registry (Apicurio)"
ring: trial
quadrant: tools
tags: [eda, contracts, governance, data-platform]
---

Apicurio Schema Registry используется как реестр схем для EDA-архитектуры.
Хранит версии Avro/Protobuf/JSON Schema контрактов для всех Kafka-топиков.
Валидирует сообщения при публикации — несовместимое изменение контракта
отклоняется на этапе деплоя, а не в рантайме. Обеспечивает эволюцию схем
в режимах BACKWARD, FORWARD, FULL совместимости. Self-hosted.
