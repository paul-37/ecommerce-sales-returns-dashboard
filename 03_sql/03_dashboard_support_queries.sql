SELECT
    DATE_TRUNC('month', InvoiceDate) AS month_start,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM v_sales_transactions
GROUP BY DATE_TRUNC('month', InvoiceDate)
ORDER BY month_start;

SELECT
    DATE_TRUNC('month', InvoiceDate) AS month_start,
    ROUND(SUM(ReturnAmount)::numeric, 2) AS return_value
FROM v_return_transactions
GROUP BY DATE_TRUNC('month', InvoiceDate)
ORDER BY month_start;

SELECT
    s.month_start,
    s.gross_sales,
    COALESCE(r.return_value, 0) AS return_value,
    ROUND((s.gross_sales - COALESCE(r.return_value, 0))::numeric, 2) AS net_sales
FROM
(
    SELECT
        DATE_TRUNC('month', InvoiceDate) AS month_start,
        SUM(SalesAmount) AS gross_sales
    FROM v_sales_transactions
    GROUP BY DATE_TRUNC('month', InvoiceDate)
) s
LEFT JOIN
(
    SELECT
        DATE_TRUNC('month', InvoiceDate) AS month_start,
        SUM(ReturnAmount) AS return_value
    FROM v_return_transactions
    GROUP BY DATE_TRUNC('month', InvoiceDate)
) r
ON s.month_start = r.month_start
ORDER BY s.month_start;

SELECT
    Country,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM v_sales_transactions
GROUP BY Country
ORDER BY gross_sales DESC
LIMIT 10;

SELECT
    Description,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM v_product_transactions
GROUP BY Description
ORDER BY gross_sales DESC
LIMIT 10;

SELECT
    Description,
    ROUND(SUM(ReturnAmount)::numeric, 2) AS return_value
FROM v_return_transactions
WHERE Description IS NOT NULL
  AND TRIM(Description) <> ''
GROUP BY Description
ORDER BY return_value DESC
LIMIT 10;

SELECT
    DATE_TRUNC('month', InvoiceDate) AS month_start,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM v_sales_transactions
GROUP BY DATE_TRUNC('month', InvoiceDate)
ORDER BY month_start;

SELECT
    ROUND(
        (
            SUM(SalesAmount) / NULLIF(COUNT(DISTINCT InvoiceNo), 0)
        )::numeric
    , 2) AS average_order_value
FROM v_sales_transactions;