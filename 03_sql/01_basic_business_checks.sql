SELECT COUNT(*) AS total_rows
FROM fact_transactions;

SELECT RowType, COUNT(*) AS row_count
FROM fact_transactions
GROUP BY RowType
ORDER BY RowType;

SELECT ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM fact_transactions
WHERE IsValidForSales = 1;

SELECT ROUND(SUM(ABS(SalesAmount))::numeric, 2) AS return_value
FROM fact_transactions
WHERE RowType = 'Return';

SELECT
    ROUND(
        (
            SELECT SUM(SalesAmount)
            FROM fact_transactions
            WHERE IsValidForSales = 1
        )::numeric
        -
        (
            SELECT SUM(ABS(SalesAmount))
            FROM fact_transactions
            WHERE RowType = 'Return'
        )::numeric
    , 2) AS net_sales;

SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM fact_transactions
WHERE IsValidForSales = 1;

SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM fact_transactions
WHERE IsValidForCustomerAnalysis = 1;

SELECT
    Country,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM fact_transactions
WHERE IsValidForSales = 1
GROUP BY Country
ORDER BY gross_sales DESC
LIMIT 10;

SELECT
    Description,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM fact_transactions
WHERE IsValidForProductAnalysis = 1
GROUP BY Description
ORDER BY gross_sales DESC
LIMIT 10;

SELECT
    DATE_TRUNC('month', InvoiceDate) AS sales_month,
    ROUND(SUM(SalesAmount)::numeric, 2) AS gross_sales
FROM fact_transactions
WHERE IsValidForSales = 1
GROUP BY DATE_TRUNC('month', InvoiceDate)
ORDER BY sales_month;