# E-Commerce Analytics Dashboard (Databricks SQL)

A 4-page analytics dashboard built in Databricks SQL to evaluate business performance, key drivers, customer cohorts, and customer delivery experience.

## What this project demonstrates
- Data modeling mindset (raw → staging → mart)
- KPI design with guardrails (active-month filtering to avoid “ghost months”)
- Customer analytics (new vs returning, cohorts/retention)
- Operational/customer experience analytics (delivery speed percentiles, late-rate drivers)
- Clear communication (dashboard explainer PDF)

## Dashboard pages (what each answers)
**Page 1 — Executive Summary & Trends**
- How are revenue, orders, AOV, delivery health, and customer mix trending?

**Page 2 — Drivers (Month-filtered)**
- Which categories, sellers, payment methods, and geographies drive results in a selected month?

**Page 3 — Cohorts**
- How do subscriber cohorts retain and generate revenue over Months +1 to +12?

**Page 4 — Customer Experience Deep Dive**
- How long delivery takes (P50/P90/P95), how often deliveries are late, and which sellers/regions most contribute to late delivery and weaker review signals.

## Key build decisions
- **New vs Returning fix:** Classified using stable `subscriber_id` (not a per-order id) to avoid mislabeling all orders as “new.”
- **Ghost-month handling:** Filtered to active months (months with real revenue/orders) to prevent tail-month nulls/zeros from distorting trends.
- **Customer experience framing:** Separated “speed” (delivery days percentiles) from “reliability” (late rate among delivered).

## Artifacts
- **Dashboard explainer (PDF):** `docs/Ecommerce_Dashboard_Overview.pdf`
- Dashboard screenshots: `docs/screenshots/`

## Tech stack
- Databricks SQL (Unity Catalog)
- Curated mart schema: `workspace.ecom_mart`

## Data notes
This project uses a sample e-commerce dataset. Raw data is not included in this repository.
