-- Dashboard: Page 3 (Cohorts)
-- Tile: Cohort Revenue Heatmap (Months +1 to +12)
-- Sources: ecom_mart.v_kpi_subscriber_cohort_revenue_12m

SELECT
  CAST(cohort_month AS DATE)      AS cohort_month,
  CAST(months_since_first AS INT) AS month_n,
  COALESCE(revenue, 0)            AS revenue
FROM ecom_mart.v_kpi_subscriber_cohort_revenue_12m
WHERE months_since_first BETWEEN 1 AND 12
ORDER BY cohort_month, month_n;
