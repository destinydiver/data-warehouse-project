## 1. gold.dim_customers
  - Purpose: Stores customer details enriched with demographic and geographic data.
  - Columns:

| Column Name | Data Type | Description |
| ----------- | --------- | ----------- |
| customer_key | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id | INT | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name | NVARCHAR(50) | The customer's first name, as recorded in the system. |
| last_name | NVARCHAR(50) |  The customer's last name. |
| country | NVARCHAR(50) | The country of residence for the customer ( e.g., 'Germany'). |
| marital_status | NVARCHAR(50) | The marital status of the customer ( e.g., 'Married', 'Single' ). |
| gender | NVARCHAR(50) | The customer's gender as recorded in system ( e.g., 'Male', 'Female', 'n/a' ). |
| birthdate | DATE | The customer's birthdate, formatted as YYYY-MM-DD ( e.g., 1982-09-06 ). |
| create_date | DATE | The date and time when the customer record was first created in the system. |


***

## 2. gold.dim_products
  - Purpose: Provides information about the products and their attributes.
  - Columns:

| Column Name | Data Type | Description |
| ----------- | --------- | ----------- |
| product_key | INT | Surrogate key uniqwuely identifying each product record in the product dimension table. |
| product_id | INT | A unique identifier assigned to the product for internal tracking and referencing. |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory. |
| product_name | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color, and size. |
| category_id | NVARCHAR(50) | A unique identifier for the product's category, linking to its high-level classification. |
| category | NVARCHAR(50) | A broader classification of the product ( e.g., Bikes, Components ) to group related items. |
| subcategory | NVARCHAR(50) | A more detailed classification of the product with the category, such as product type specifics. |
| maintenance | NVARCHAR(50) | Indicates whether the product requires maintenance ( e.g., 'Yes', 'No' ). |
| cost | INT | The cost or base price of the product, measured in monetary units ( U.S. Dollar ). |
| product_line | NVARCHAR(50) | The specific product line or series to which the product belongs ( e.g., Rpad. Mountain ). |
| start_date | DATE | The date when the product became available for sale or use. |



***

## 3. gold.fact_sales
  - Purpose: Stores transactional sales data for analytical purposes.
  - Columns:

| Column Name | Data Type | Description |
| ----------- | --------- | ----------- |
| order_number | NVARCHAR(50) | A unique alphanumeric identifier for each sales order ( e.g., 'SO353378' ). |
| product_key | INT | A Surrogate key linking the order to the product dimension table. |
| customer_key | INT | A Surrogate key linking the order to the Customer dimension table. |
| order_date | DATE | The date that the order was placed. |
| shipping_date | DATE | The date that the order was shipped. |
| due_date | DATE | The date that the payment for the order was due. |
| sales | INT | The total amount of sales for that record in US Dollars ( in whole Dollars ). |
| quantity | INT | The number of units of that product ordered for that record. |
| price | INT | The price per unit in whole US Dollars. |
