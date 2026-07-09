# Online Retail Sales Analytics

End-to-end retail analytics project: raw transactional data cleaned in Python, modelled in Power BI, and presented as a single-page executive dashboard with interactive filtering and DAX measures.

---

## Business Problem

An online retailer needs to understand what drives its revenue: which products sell, which markets matter, and how sales trend over time. This project turns ~500K raw transaction records into a clean dataset and an executive dashboard that answers those questions at a glance.

---

## Dataset

**Online Retail II** — UCI Machine Learning Repository
Real e-commerce transactions from a UK-based online retailer.
Source: https://archive.ics.uci.edu/dataset/502/online+retail+ii

Columns: `Invoice`, `StockCode`, `Description`, `Quantity`, `InvoiceDate`, `Price`, `Customer ID`, `Country`.

> The raw file is **not committed** to this repo (it is large and publicly available at the link above). Download it into `/data` to reproduce.

---

## Tools & Skills Demonstrated

| Tool | Used for |
|------|----------|
| **Python (pandas)** | Data loading, cleaning, and exploratory analysis |
| **Power BI** | Data modelling and interactive dashboard |
| **DAX** | Custom measures (Total Revenue, Total Orders, Average Order Value) |
| **Excel** | Source data format and quick validation |
| **Git / GitHub** | Version control and portfolio hosting |

---

## Data Cleaning Pipeline (Python)

Raw records were cleaned in `notebooks/01_data_cleaning_eda.ipynb`:

1. Removed rows with a missing `Description`
2. Removed rows with a missing `Customer ID`
3. Removed returns and cancellations (`Quantity <= 0`)
4. Removed invalid prices (`Price <= 0`)
5. Removed exact duplicate rows
6. Derived a **Revenue** column (`Quantity × Price`)

**Result:** 525,461 raw rows → **400,916 clean rows** (~24% removed as invalid, cancelled, or incomplete).

The cleaned output is used as the single source for the Power BI model (`online_retail_cleaned`).

---

## Dashboard — Executive Summary

A single-page Power BI report (`powerbi/online-retail-sales-dashboard.pbix`):

- **KPI cards:** Total Revenue, Total Orders, Average Order Value
- **Revenue over time:** monthly revenue trend line
- **Top products:** revenue by product (clustered bar)
- **Country slicer:** filter the entire page by market
- **Detail table:** transaction-level breakdown

**DAX measures**
- `Total Revenue` — sum of revenue across transactions
- `Total Orders` — count of distinct invoices
- `Average Order Value` — Total Revenue ÷ Total Orders

![Dashboard](images/dashboard.png)

---



## Repository Structure

```
online-retail-sales-analytics/
├── README.md
├── notebooks/
│   └── 01_data_cleaning_eda.ipynb
├── powerbi/
│   └── online-retail-sales-dashboard.pbix
├── images/
│   └── dashboard.png
└── data/
    └── (download Online Retail II from UCI — not committed)
```

---

## How to Reproduce

1. Download the **Online Retail II** dataset from UCI (link above) into `/data`.
2. Run `notebooks/01_data_cleaning_eda.ipynb` to clean the data and export the cleaned file.
3. Open `powerbi/online-retail-sales-dashboard.pbix` in Power BI Desktop and refresh.

---

## Author

**Uthej Alagani** — Data Engineer / Data Analyst
MSc Data Science & Analytics, Maynooth University · Databricks Certified Data Engineer Associate
[LinkedIn](#) · [GitHub](#)
