CREATE OR REPLACE VIEW v_fact_transactions_model AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    CAST(InvoiceDate AS DATE) AS InvoiceDateOnly,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM fact_transactions;

CREATE OR REPLACE VIEW dim_date AS
SELECT DISTINCT
    CAST(InvoiceDate AS DATE) AS invoice_date,
    EXTRACT(YEAR FROM CAST(InvoiceDate AS DATE)) AS year,
    EXTRACT(MONTH FROM CAST(InvoiceDate AS DATE)) AS month_number,
    TO_CHAR(CAST(InvoiceDate AS DATE), 'Month') AS month_name,
    TO_CHAR(CAST(InvoiceDate AS DATE), 'YYYY-MM') AS year_month,
    EXTRACT(QUARTER FROM CAST(InvoiceDate AS DATE)) AS quarter
FROM fact_transactions
ORDER BY invoice_date;

CREATE OR REPLACE VIEW dim_country AS
SELECT DISTINCT
    Country
FROM fact_transactions
WHERE Country IS NOT NULL
  AND TRIM(Country) <> ''
ORDER BY Country;

CREATE OR REPLACE VIEW dim_product AS
SELECT DISTINCT
    StockCode,
    Description
FROM v_product_transactions_clean
WHERE StockCode IS NOT NULL
  AND TRIM(StockCode) <> ''
  AND Description IS NOT NULL
  AND TRIM(Description) <> ''
ORDER BY StockCode, Description;

CREATE OR REPLACE VIEW dim_customer AS
SELECT DISTINCT
    CustomerID
FROM fact_transactions
WHERE CustomerID IS NOT NULL
  AND TRIM(CustomerID) <> ''
ORDER BY CustomerID;

