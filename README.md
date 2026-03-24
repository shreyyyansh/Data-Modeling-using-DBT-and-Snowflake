# Data Modeling using dbt and Snowflake

## Project Overview

This project demonstrates an end-to-end data modeling pipeline built using dbt (Data Build Tool) and Snowflake. It follows a layered architecture (L1 to L3) to transform raw data into business-ready analytics tables, ensuring data quality through testing and modular transformations.

---
## Snowflake View

<img width="1909" height="876" alt="image" src="https://github.com/user-attachments/assets/039dd3df-1fbf-46b8-af27-9bc65d39a177" />





---

## Architecture

```
L1_LANDING (Raw Data)
        |
        v
L2_PROCESSING (Staging Layer - Views)
        |
        v
L3_CONSUMPTION (Fact & Mart Layer - Tables)
```

---

## Tech Stack

- **Snowflake** - Cloud Data Warehouse
- **dbt (Data Build Tool)** - Data Transformation
- **SQL** - Querying and Modeling
- **Git and GitHub** - Version Control

---

## Data Pipeline Flow

```
Raw Tables (Snowflake)
        |
        v
source() -- Ingest raw data
        |
        v
Staging Models (Cleaning & Transformation)
        |
        v
ref() -- Build dependencies
        |
        v
Fact Tables (Metrics Calculation)
        |
        v
Final Models (Business Insights)
```

---

## Project Structure

```
|-- analyses/
|   |-- StoreRevenue.sql
|
|-- macros/
|   |-- generate_schema_n...         # Custom schema generation macro
|
|-- models/
|   |-- customers_stg.sql            # Staging: cleaned customer data
|   |-- customerorders.sql           # Customer order aggregation
|   |-- customerrevenue.sql          # Customer revenue calculation
|   |-- orderitems_stg.sql           # Staging: cleaned order items
|   |-- orders_stg.sql               # Staging: cleaned orders
|   |-- orders_fact.sql              # Fact table: order metrics
|   |-- storeperformance.sql         # Store-level sales analysis
|   |-- simple_jinja_code.sql        # Jinja macro usage example
|   |-- src_oms.yml                  # Source definitions
|   |-- oms_config.yml               # Model configurations
|   |-- oms_doc_blocks.md            # Documentation blocks
|
|-- seeds/
|   |-- salesargets.csv              # Static reference: sales targets
|
|-- snapshots/                       # SCD / snapshot models
|
|-- tests/
|   |-- generic/                     # Generic test overrides
|   |-- orders_fact_negative_re...   # Custom test: no negative revenue
|   |-- record_count_check.sql       # Custom test: row count validation
|
|-- dbt_project.yml                  # Project configuration
|-- README.md
```

---

## Key Concepts Used

- **source()** - Connect raw Snowflake tables
- **ref()** - Build model dependencies (DAG)
- **Materializations** - `view` for staging models, `table` for final models
- **CTEs** - Modular SQL transformations
- **Seeds** - Static reference data
- **Tests** - Data quality validation (not null, unique, custom tests)

---

## Example Transformations

- Customer order aggregation
- Revenue calculation from order items
- Store-level sales analysis
- Target vs actual sales comparison

---

## Data Quality Checks

Implemented using dbt tests:

- Not null checks
- Unique constraints
- Custom business rules (e.g., no negative revenue)
- Row count validation tests

---

## How to Run This Project

**1. Clone the repository**

```bash
git clone https://github.com/shreyyyansh/Data-Modeling-using-DBT-and-Snowflake.git
cd Data-Modeling-using-DBT-and-Snowflake
```

**2. Create a virtual environment**

```bash
python -m venv dbt_venv
.\dbt_venv\Scripts\Activate.ps1
```

**3. Install dependencies**

```bash
pip install dbt-snowflake
```

**4. Configure Snowflake connection**

Update your `profiles.yml`:

```yaml
<project_name>:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your_account>
      user: <your_username>
      password: <your_password>
      role: ACCOUNTADMIN
      database: SLEEKMART_OMS
      warehouse: COMPUTE_WH
      schema: L3_CONSUMPTION
      threads: 1
```

**5. Run the pipeline**

```bash
dbt debug
dbt seed
dbt run
dbt test
```

**6. Generate and serve documentation**

```bash
dbt docs generate
dbt docs serve
```

This will compile your project documentation and launch a local web server (default: `http://localhost:8080`) where you can explore the full lineage DAG, model descriptions, source definitions, and test coverage.

---

## Output

The pipeline generates:

- Cleaned staging tables
- Fact tables (orders, revenue)
- Aggregated business models (customer revenue, store performance)

These tables are ready to be consumed by BI tools such as Power BI or Tableau.

---

## Learning Outcomes

Through this project, hands-on experience was gained in:

- Building modular data pipelines using dbt
- Implementing layered data modeling (L1 to L3)
- Writing efficient SQL transformations
- Ensuring data quality using dbt tests
- Understanding the modern data stack (dbt + Snowflake)

---

## Resources

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [dbt Discourse](https://discourse.getdbt.com/) - Commonly asked questions and answers
- [dbt Community Slack](https://community.getdbt.com/) - Live discussions and support
- [dbt Events](https://events.getdbt.com)
- [dbt Blog](https://blog.getdbt.com/) - Latest news and best practices
