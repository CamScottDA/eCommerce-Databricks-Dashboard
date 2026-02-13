-- Dashboard: Page 2 (Drivers)
-- Tile: Payment Mix
-- Notes: Filtered by Page 2 month filter (month_start)
-- Sources: ecom_mart.v_kpi_payment_mix_monthly

WITH active_months AS (
  SELECT CAST(month_start AS DATE) AS month_start_date
  FROM ecom_mart.v_kpi_monthly
  WHERE total_item_revenue > 0
)
SELECT
  CAST(p.month_start AS DATE) AS month_start_date,
  CASE
    WHEN p.payment_type = 'not_defined' THEN 'Undefined'
    ELSE initcap(replace(p.payment_type, '_', ' '))
  END AS payment_type,
  p.orders_with_payment_type,
  p.payment_value,
  p.avg_installments
FROM ecom_mart.v_kpi_payment_mix_monthly p
JOIN active_months a
  ON CAST(p.month_start AS DATE) = a.month_start_date
ORDER BY
  month_start_date,
  payment_type;
