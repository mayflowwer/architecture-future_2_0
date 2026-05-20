---
title: "Apache Camel"
ring: trial
quadrant: tools
tags: [integration, eda, adapter, esb, data-platform]
---

Apache Camel используется как адаптерный слой для интеграции доменов
с различными протоколами (HL7, DICOM, SOAP, REST, FTP) в единую
EDA-шину на базе Kafka. Реализует паттерн Message Translator —
трансформирует входящие события в canonical-формат перед публикацией
в Kafka. Заменяет монолитную ESB, оставаясь тонким протокольным
адаптером без накопления бизнес-логики. Self-hosted.
