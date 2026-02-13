-- Dashboard: Page 2 (Drivers)
-- Tile: Top Sellers (Top 10)
-- Notes: Intended to be filtered by the Page 2 month filter (month_start)
-- Sources: ecom_mart.v_top_sellers_monthly

SELECT
  CAST(month_start AS DATE) AS month_start_date,
  seller_rank,
  seller_name,
  seller_country,
  revenue,
  orders,
  items,
  avg_review_score,
  late_rate_among_delivered
FROM ecom_mart.v_top_sellers_monthly
ORDER BY month_start_date, seller_rank;

