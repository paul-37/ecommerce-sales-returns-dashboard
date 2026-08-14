# E-commerce Sales and Returns Reporting Dashboard

## Project Overview
This project analyses online retail transaction data to build a sales and returns reporting dashboard using SQL and Power BI.

The dashboard helps track gross sales, return value, net sales, order activity, customer activity, country performance, product performance, and return trends.

## Business Problem
A retail business needs a reporting solution to understand sales performance and the impact of product returns/cancellations.

The main business questions are:
- How much gross sales did the business generate?
- How much value was lost through returns?
- What is net sales after returns?
- Which countries generate the most sales?
- Which products generate the most sales?
- Which products contribute most to return value?
- Are sales and returns changing over time?

## Dataset
Dataset: Online Retail  
Source: UCI Machine Learning Repository  

The dataset contains online retail transaction data with fields such as:
- InvoiceNo
- StockCode
- Description
- Quantity
- InvoiceDate
- UnitPrice
- CustomerID
- Country

## Tools Used
- Excel: initial inspection and helper-column preparation
- PostgreSQL: database storage and SQL analysis
- DBeaver: SQL development
- Power BI: data model, DAX measures, and dashboard design
- GitHub: project documentation

## Project Structure
```text
ecommerce-sales-returns-dashboard/
├── 01_raw_data/
├── 02_cleaned_data/
├── 03_sql/
├── 04_powerbi/
├── 05_docs/
├── 06_images/
└── 07_resume_notes/


The raw and cleaned data files are not included in this repository due to file size and storage considerations. The dataset source is the UCI Online Retail dataset, and the cleaning process is documented in the project files.
