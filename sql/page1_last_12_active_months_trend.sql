-- Dashboard: Page 1 (Executive Summary)
-- Tile: Trend (Last 12 active months)
-- Purpose: Avoid ghost months by using the latest active month window
-- Sources: ecom_mart.v_kpi_monthly

WITH bounds AS (
  SELECT MAX(month_start) AS max_month
  FROM ecom_mart.v_kpi_monthly
  WHERE total_item_revenue > 0
)
SELECT
  CAST(m.month_start AS DATE) AS month_start,
  m.total_item_revenue,
  m.total_orders,
  m.aov_orders_with_items
FROM ecom_mart.v_kpi_monthly m
CROSS JOIN bounds b
WHERE m.month_start >= add_months(b.max_month, -11)
  AND m.month_start <= b.max_month
ORDER BY m.month_start;
