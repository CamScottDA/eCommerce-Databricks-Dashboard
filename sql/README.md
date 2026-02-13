# SQL Index (Databricks SQL)

This folder contains the SQL used to power the dashboard tiles. Queries are organized by dashboard page.

## Page 1 — Executive Summary & Trends
- [Last 12 Active Months Trend](page1_last_12_active_months_trend.sql)
- [New vs Returning Revenue (Monthly)](page1_new_vs_returning_revenue_monthly.sql)

## Page 2 — Drivers
- [Top Sellers (Top 10)](page2_top_sellers_top10.sql)
- [Payment Mix](page2_payment_mix.sql)

## Page 3 — Cohorts
- [Cohort Retention Heatmap](page3_cohort_retention_heatmap.sql)
- [Cohort Revenue Heatmap](page3_cohort_revenue_heatmap.sql)
- [Late Rate Among Delivered (Monthly)](page3_late_rate_among_delivered_monthly.sql)

## Page 4 — Customer Experience Deep Dive
- [At-Risk Sellers (Top 50)](page4_at_risk_sellers.sql)
- [Delivery Speed Percentiles KPI](page4_kpis_delivery_percentiles.sql)
- [Late Rate KPI](page4_kpi_late_rate_among_delivered.sql)
- [Review Score vs Lateness (Scatter)](page4_scatter_review_score_vs_lateness.sql)
- [Late Rate by Seller Country](page4_late_rate_by_seller_country.sql)

## Notes
- Sources are in `workspace.ecom_mart` unless otherwise stated.
- Many tiles use an active-month filter to avoid “ghost months” at the dataset tail.
- Parameters are documented in the header comments of each SQL file (e.g., `:min_orders`).
