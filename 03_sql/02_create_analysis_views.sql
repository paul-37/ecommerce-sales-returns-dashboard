CREATE OR REPLACE VIEW v_sales_transactions AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM fact_transactions
WHERE IsValidForSales = 1;

CREATE OR REPLACE VIEW v_return_transactions AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    ABS(SalesAmount) AS ReturnAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM fact_transactions
WHERE RowType = 'Return';

CREATE OR REPLACE VIEW v_customer_transactions AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM fact_transactions
WHERE IsValidForCustomerAnalysis = 1;

CREATE OR REPLACE VIEW v_product_transactions AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM fact_transactions
WHERE IsValidForProductAnalysis = 1;

CREATE OR REPLACE VIEW v_product_transactions_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM v_product_transactions
WHERE UPPER(TRIM(Description)) NOT IN (
    'DOTCOM POSTAGE',
    'POSTAGE',
    'PACKING CHARGE',
    'BANK CHARGES',
    'AMAZON FEE',
    'MANUAL',
    'ADJUST BAD DEBT',
    'DOTCOM ADJUST',
    'ADJUST',
    'ADJUSTMENT',
    'OOPS ! ADJUSTMENT',
    'RE-ADJUSTMENT',
    'REVERSE 21/5/10 ADJUSTMENT',
    'REVERSE PREVIOUS ADJUSTMENT',
    'AMAZON ADJUSTMENT',
    'TAIG ADJUST',
    'TAIG ADJUST NO STOCK',
    'TEMP ADJUSTMENT',
    'AMAZON ADJUST',
    'AMAZON',
    'AMAZON SOLD SETS',
    'AMAZON SALES',
    'SOLD AS SET ON DOTCOM AND AMAZON'
);

CREATE OR REPLACE VIEW v_return_products_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    SalesAmount,
    ReturnAmount,
    RowType,
    IsReturn,
    IsValidForSales,
    IsValidForCustomerAnalysis,
    IsValidForProductAnalysis
FROM v_return_transactions
WHERE Description IS NOT NULL
  AND TRIM(Description) <> ''
  AND UPPER(TRIM(Description)) NOT IN (
    'DOTCOM POSTAGE',
    'POSTAGE',
    'PACKING CHARGE',
    'BANK CHARGES',
    'AMAZON FEE',
    'MANUAL',
    'ADJUST BAD DEBT',
    'DOTCOM ADJUST',
    'ADJUST',
    'ADJUSTMENT',
    'OOPS ! ADJUSTMENT',
    'RE-ADJUSTMENT',
    'REVERSE 21/5/10 ADJUSTMENT',
    'REVERSE PREVIOUS ADJUSTMENT',
    'AMAZON ADJUSTMENT',
    'TAIG ADJUST',
    'TAIG ADJUST NO STOCK',
    'TEMP ADJUSTMENT',
    'AMAZON ADJUST',
    'AMAZON',
    'AMAZON SOLD SETS',
    'AMAZON SALES',
    'SOLD AS SET ON DOTCOM AND AMAZON'
);