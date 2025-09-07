# Data Warehouse and Analytics Project

Building a modern data warehouse with SQL Server, including ETL processes, data modeling, and analytics.
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data
warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best 
practices in data engineering and analytics.

---

## Project Overview

### This project involves:
- **Data Architecture**: Designing a modern data warehouse using Medallion Architecture: Bronze, Silver, and Gold Layers.
- **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the data warehouse.
- **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
- **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

---
##  Project Requirements

### Building the Data Warehouse ( Data Engineering )

#### Specifications
- **Data Sources**:  Import data from two soruce systems ( ERP and CRM ) provided as CSV files.
- **Data Quality**:  Cleanse and resolve data quality issues prior to analysis.
- **Integration**:  Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**:  Focus on the latest dataset only; historization of data is not required.
- **Documentation**:  Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

## Data Architecture
![image alt](https://github.com/destinydiver/data-warehouse-project/blob/87a7e7fc8af0f7538086f4ceffd309d9d02ee8bd/Data_Warehouse_Architecture.png)


---

## Data-Flow Diagram
![image alt](https://github.com/destinydiver/data-warehouse-project/blob/b06ff7464be27af92a3b039615bb5e70e952082f/Data%20Warehouse%20Data%20Flow%20Diagram.drawio.png)


---


## Gold Layer - Sales Data Mart
![image alt](https://github.com/destinydiver/data-warehouse-project/blob/baf6d30bb4c6cb0acf13ea31c28c09eb0a146bab/Sales_Data_Mart.drawio.png)

---

## Data Sources - Entity Relationship Diagram
![image alt](https://github.com/destinydiver/data-warehouse-project/blob/f669ae194c96cc2814419c3e27849086381fca5f/DWH%20Entity%20Relationship%20Diagram.png)

---


# How to Download and Load Datasets into the Bronze Layer

Follow these steps to download the [`data-warehouse-project`](https://github.com/destinydiver/data-warehouse-project) repository, create and initialize the database,
, create the tables, and load the included CSV datasets into the bronze layer. Then, sequentially execute scripts to load data from the bronze layer to silver layer;
cleansing and transforming the data in the process. Finally, executing the gold layer script will take the cleansed and transformed data from the silver layer and
create three views in a star schema; 2 dimension tables (gold.dim_customers & gold.dim_products) expounding on data in the fact table (gold.fact_sales).

---

### 1. Clone the Repository

You can clone project from GitHub or open a terminal and run:

```bash
git clone https://github.com/destinydiver/data-warehouse-project.git
cd data-warehouse-project
```

---

### 2. Execute the `init_database.sql` script in the data-warehouse-project/scripts directory.
This will create the database and the three shcemas: bronze, silver, and gold.

---

### 3. Place the datasets ( CSV files ) on your system and make note of the file path.
These files will be local on your machine, but they are to mimick an ETL process on two data sources:
- CRM - Customer Relationship Management System ( 3 csv files )
- ERP - Enterprise Resource Planning Data System ( 3 csv files ).

---

### 4. Execute script:  `data-warehouse-project/scrpts/bronze/ddl_bronze.sql`.
This will create and set up the bronze tables.

--- 

### 5. Open script `data-warehouse-project/scripts/bronze/proc_load_bronze.sql` in a text editor.
Update the six 'FROM' clauses to properly reflect the filepaths to each corresponding
CSV file on your computer. For example, this is the file path on my system to load the  `cust_info.csv` into
the corresponding `bronze.crm_cust_info` table:  
`FROM 'C:\sql\dwh_project\datasets\source_crm\cust_info.csv'`

---

### 6. Execute bronze script `data-warehouse-project/scripts/bronze/proc_load_bronze.sql`.
Once you have updated the six 'FROM' clauses outlined in step #5, you can run this scrpt to actually
load the data into the bronze layer tables. This only loads the data, there is no modifications at
all done on the data. This is to aid in troubleshooting issues as well as tracking purposes.

---

### 7. Verify the Data Load
After running the script, check the bronze layer tables to ensure data loaded correctly.
For Example:
```sql
SELECT * FROM bronze.crm_cust_info LIMIT 10;
```

### 8. Execute script `data-warehouse-project/scripts/silver/DDL_silver.sql`
This will create the silver tables.

---
### 9. Execute script `data-warehouse-project/scrpts/silver/proc_load_silver.sql`
This script will load data from the bronze tables into the corresponding silver tables and in the 
process, cleanse and transform the data for consistency and readability. After running this script
verify the loading by running checks for silver layer listed in the `Tests` directory.

---
### 10. Execute script `data-warehouse-project/scripts/gold/ddl_gold.sql`
This will create 3 views in a star schema configuration with gold.fact_sales at the center and
2 dimension tables: gold.dim_customers and gold.dim_products. After the execution of this scrpt,
execute the gold quality checks in the   `Tests` directory.

---


### 11. Troubleshooting

- Double-check file paths in the SQL script.
- Ensure you have necessary database permissions.
- Review any errors from your database client for clues.

---

## Summary

1. Clone the repo and locate the `datasets` directory.
2. Review and, if needed, update the `proc_load_bronze.SQL` script.
3. Run the script in your database environment.
4. Verify the data was loaded into the bronze layer.

If you have issues, review error messages and check your environment setup.

---


## Important Links & Tools
### Everything is free!
- [Datasets](https://github.com/destinydiver/data-warehouse-project/tree/ac096087796bb42fceb38f2bbcee2e821316603b/datasets): Access to the project dataset ( csv files ).
- [Naming Convention](https://github.com/destinydiver/data-warehouse-project/blob/dbe589b86ecee83b035dbcc9180470da299a92d0/naming_conventions.md): Details of project naming scheme.
- [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads): Lightweight server for hosting your SQL database.
- [SQL Server Management Studion (SSMS)](https://www.microsoft.com/en-us/sql-server/sql-server-downloads#SQL-tools-and-drivers): GUI for managing and interacting with databases.
- [Git Repository](https://github.com/): Set up a GitHub account and repository to manage, version, and collaborate on your code efficiently.
- [DrawIO](https://www.drawio.com/doc/): Design data architecture, models, flows, and diagrams.
- [Notion](https://www.notion.com/): All-in-one tool for project management and organization.
- [Notion Project Steps](https://www.notion.so/23126127c66d802fb26fedd314f52146?v=23126127c66d80df8fcf000c8113f68b&source=copy_link): Access to all project phases and tasks.
---

### BI:  Analytics & Reporting ( Data Analytics )

### Objective
Develop SQL-based analytics to deliver detailed insights into:
-**Customer Behavior**
-**Product Performance**
-**Sales Trends**
These insights empowerr stakeholders with key business metrics, enabling strategic decion-making.

---

##  License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

##  About Me

Hi, my name is Chuck
