-- Dashboard: Page 3 (Cohorts)
-- Tile: Retention Heatmap (Months +1 to +12; excludes Month 0)
-- Notes: Filters small cohorts to reduce 1-person artifacts
-- Sources: ecom_mart.v_kpi_subscriber_cohort_retention_12m

WITH big_cohorts AS (
  SELECT CAST(cohort_month AS DATE) AS cohort_month
  FROM ecom_mart.v_kpi_subscriber_cohort_retention_12m
  WHERE months_since_first = 0
  GROUP BY CAST(cohort_month AS DATE)
  HAVING MAX(cohort_size) >= 50
)
SELECT
  CAST(r.cohort_month AS DATE)      AS cohort_month,
  CAST(r.months_since_first AS INT) AS month_n,
  LEAST(COALESCE(r.retention_rate, 0), 0.01) AS retention_rate
FROM ecom_mart.v_kpi_subscriber_cohort_retention_12m r
JOIN big_cohorts b
  ON CAST(r.cohort_month AS DATE) = b.cohort_month
WHERE r.months_since_first BETWEEN 1 AND 12
ORDER BY cohort_month, month_n;
