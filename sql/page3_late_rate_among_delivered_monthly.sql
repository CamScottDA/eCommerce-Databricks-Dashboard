-- Dashboard: Page 3 (Cohorts)
-- Tile: Late Rate Among Delivered (Monthly)
-- Notes: Filters months with zero delivered to avoid null/ghost-month artifacts
-- Sources: ecom_mart.v_kpi_delivery_monthly

SELECT
  CAST(month_start AS DATE) AS month_start,
  orders_delivered,
  on_time_rate_among_delivered,
  late_rate_among_delivered,
  avg_delivery_days
FROM ecom_mart.v_kpi_delivery_monthly
WHERE month_start IS NOT NULL
  AND orders_delivered > 0
ORDER BY month_start;
