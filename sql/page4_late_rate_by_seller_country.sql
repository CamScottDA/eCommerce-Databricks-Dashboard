-- Dashboard: Page 4 (Customer Experience)
-- Tile: Late Rate by Seller Country
-- Notes: Orders-weighted rollup across active months; minimum order threshold reduces noise
-- Params: :min_orders
-- Sources: ecom_mart.v_top_sellers_monthly, ecom_mart.v_kpi_monthly

WITH active_months AS (
  SELECT month_start
  FROM ecom_mart.v_kpi_monthly
  WHERE total_item_revenue > 0
),
base AS (
  SELECT
    s.seller_country,
    s.orders,
    s.revenue,
    s.late_rate_among_delivered
  FROM ecom_mart.v_top_sellers_monthly s
  INNER JOIN active_months a
    ON s.month_start = a.month_start
  WHERE s.orders > 0
    AND s.late_rate_among_delivered IS NOT NULL
),
country_rollup AS (
  SELECT
    seller_country,
    SUM(orders)  AS orders,
    SUM(revenue) AS revenue,
    SUM(late_rate_among_delivered * orders) / NULLIF(SUM(orders), 0) AS late_rate_among_delivered
  FROM base
  GROUP BY seller_country
)
SELECT
  seller_country,
  orders,
  revenue,
  late_rate_among_delivered
FROM country_rollup
WHERE orders >= :min_orders
ORDER BY late_rate_among_delivered DESC, orders DESC;
