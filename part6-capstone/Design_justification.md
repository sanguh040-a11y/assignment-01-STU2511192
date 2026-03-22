# Design Justification

## Storage Systems

For the hospital network AI system, each of the four goals required specific storage solutions optimized for their use case:

1. **Predicting patient readmission risk:** This depends on historical treatment data and engineered features. The raw transactional data is stored in a traditional OLTP relational database (PostgreSQL) that supports complex queries and ACID compliance. To enable scalable and efficient model training and inference, a Feature Store (such as Feast) is employed to manage curated, ready-to-use features. This decouples feature engineering from raw data storage and speeds up ML workflows.

2. **Allowing doctors to query patient history:** For real-time, low-latency access to patient records, the OLTP database is the primary storage. Its normalized schema supports various queries doctors may pose in natural language, which are translated to SQL. The OLTP DB is designed for transactional workloads with strong consistency, suitable for mission-critical patient data.

3. **Generating monthly reports:** These reports require aggregations and historical trends across hospital departments and beds. Hence, a separate data warehouse system (e.g., Amazon Redshift or Snowflake) is used for OLAP workloads. Data is loaded periodically via ETL jobs from OLTP and time-series DB to the warehouse, enabling fast analytical queries without impacting transactional system performance.

4. **Streaming and storing real-time vitals:** ICU devices generate high-frequency vitals data streamed continuously. A specialized Time-Series Database (such as TimescaleDB or InfluxDB) is used to efficiently store, query, and aggregate this data due to its write-optimized, time-indexed schema. This allows for both real-time alerting and downstream batch aggregation for analytics.

---

## OLTP vs OLAP Boundary

In this architecture, the boundary between OLTP and OLAP systems is clearly defined:

- The OLTP system handles all transaction processing and real-time operational data management (patient records, treatment details, doctor queries). It ensures ACID properties, supports concurrent user access, and prioritizes low latency.

- A dedicated ETL pipeline extracts and transforms data from the OLTP database and the time-series database (for vitals) into a data warehouse optimized for analytical queries. This analytical layer supports complex aggregations, historical trend analysis, and large-scale reporting parallel to but separated from OLTP operations.

Separating OLTP from OLAP workloads prevents analytical query load from impacting transactional system responsiveness and allows each system to be optimized per its workload.

---

## Trade-offs

One significant trade-off in the design is the complexity and latency introduced by separating OLTP and OLAP systems. ETL pipelines require scheduled batch jobs (e.g., hourly or daily), which means analytical reports and AI models depending on warehouse data may not reflect real-time patient info immediately.

**Mitigation:**

To reduce latency, a hybrid approach can be introduced. Critical features for readmission risk prediction that need freshness can be incrementally updated in near real-time via Change Data Capture (CDC) mechanisms feeding the Feature Store, bypassing full batch ETL. Also, streaming analytics platforms (e.g., Apache Kafka + ksqlDB) can perform continuous aggregations on vitals data enabling faster updates to dashboards.

Though increasing architectural and operational complexity, this mitigates the stale data problem inherent in traditional batch ETL, balancing freshness and system maintainability.

---

This modular storage and data flow design aligns well with the hospital network’s functional needs, scalability requirements, and the demands of real-time and analytical workloads.