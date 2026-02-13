-- Dashboard: Page 4 (Customer Experience)
-- Tile: At-Risk Sellers (Late Delivery Impact) - Top 50 overall
-- Params: :min_orders> 50
-- Sources: ecom_mart.v_top_sellers_monthly, ecom_mart.v_kpi_monthly


-- Page 4 Tile 4 dataset: At-Risk Sellers scorecard (overall, not time-filtered)
-- Uses only: ecom_mart.v_top_sellers_monthly, ecom_mart.v_kpi_monthly

WITH active_months AS (
  SELECT month_start
  FROM ecom_mart.v_kpi_monthly
  WHERE total_item_revenue > 0
),
base AS (
  SELECT
    s.seller_id,
    s.seller_name,
    s.seller_country,
    s.orders,
    s.items,
    s.revenue,
    s.avg_review_score,
    s.late_rate_among_delivered
  FROM ecom_mart.v_top_sellers_monthly s
  INNER JOIN active_months a
    ON s.month_start = a.month_start
  WHERE s.orders > 0
    AND s.late_rate_among_delivered IS NOT NULL
),
seller_rollup AS (
  SELECT
    seller_id,
    seller_name,
    seller_country,
    SUM(orders)  AS orders,
    SUM(items)   AS items,
    SUM(revenue) AS revenue,

    -- Weighted averages by orders (stable rollup)
    SUM(COALESCE(avg_review_score, 0) * orders) / NULLIF(SUM(orders), 0) AS avg_review_score,
    SUM(late_rate_among_delivered * orders) / NULLIF(SUM(orders), 0)     AS late_rate_among_delivered
  FROM base
  GROUP BY seller_id, seller_name, seller_country
),
scored AS (
  SELECT
    seller_id,
    seller_name,
    seller_country,
    orders,
    items,
    revenue,
    avg_review_score,
    late_rate_among_delivered,

    -- "Impact" proxy: expected late orders (approx) = late rate * orders
    (late_rate_among_delivered * orders) AS late_impact_proxy
  FROM seller_rollup
  WHERE orders >= :min_orders
)
SELECT
  seller_id,
  seller_name,
  seller_country,
  orders,
  items,
  revenue,
  avg_review_score,
  late_rate_among_delivered,
  late_impact_proxy
FROM scored
ORDER BY late_impact_proxy DESC, late_rate_among_delivered DESC
LIMIT 25;
