-- Dashboard: Page 2 (Drivers)
-- Tile: Top Sellers (Top 10)
-- Notes: Intended to be filtered by the Page 2 month filter (month_start)
-- Sources: ecom_mart.v_top_sellers_monthly

SELECT
  month_start,
  seller_id,
  seller_name,
  seller_country,
  revenue,
  orders,
  items,
  avg_review_score,
  late_rate_among_delivered,
  seller_rank
FROM ecom_mart.v_top_sellers_monthly
WHERE seller_rank <= 10
ORDER BY seller_rank;
