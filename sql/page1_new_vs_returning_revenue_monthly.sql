-- Dashboard: Page 1 (Executive Summary)
-- Tile: New vs Returning Revenue Composition (monthly)
-- Notes: Uses subscriber-level identity (not per-order transaction id)
-- Sources: ecom_mart.v_kpi_new_vs_returning_revenue_monthly

WITH monthly AS (
  SELECT
    month_start,
    SUM(CASE WHEN customer_type = 'new' THEN revenue ELSE 0 END)       AS new_revenue,
    SUM(CASE WHEN customer_type = 'returning' THEN revenue ELSE 0 END) AS returning_revenue,
    SUM(revenue) AS total_revenue
  FROM ecom_mart.v_kpi_new_vs_returning_revenue_monthly
  GROUP BY month_start
),
bounds AS (
  SELECT max(month_start) AS max_month
  FROM monthly
  WHERE total_revenue > 0
)
SELECT
  CAST(m.month_start AS DATE) AS month_start,
  m.new_revenue,
  m.returning_revenue
FROM monthly m
CROSS JOIN bounds b
WHERE m.total_revenue > 0
  AND m.month_start >= add_months(b.max_month, -11)
  AND m.month_start <= b.max_month
ORDER BY m.month_start;
