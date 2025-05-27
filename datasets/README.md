
## 🗃️ Dataset Structure

This source file contains two directories: one from the Customer RElationship Management (CRM) source and another from the Enterprise Resource Planning (ERP) source. The contents of each directory are shown below, with descriptions of each file in the following section.

```
dataset/
├── source_crm
│   ├── cust_info.csv             # Customer information table         
│   ├── prd_info.csv              # Product information table
│   ├── sales_details.csv         # Sales information table
└── source_erp
    ├── cust_az12.csv             # Customer extra information table
    ├── erp_loc_a101.csv          # Location information table 
    ├── erp_px_cat_g1v2.csv       # Product category information table
```

➡️ For more info about the dataset please visit `doc/warehouse/` [Link](https://github.com/Rudra-G-23/SQL-Data-Warehouse-Project/tree/main/docs/warehouse)

---

## 🗄️ Tables

### ➡️ 1. Customer Information (`source_crm/cust_info.csv`)

This table stores core information about customers.

| Column Name        | Data Type     | Description                                     |
|-------------------|---------------|-------------------------------------------------|
| `cst_id`          | INT (Primary Key)| Unique identifier for each customer.           |
| `cst_key`         | VARCHAR(255) | Unique key for the customer (e.g., UUID).       |
| `cst_firstname`   | VARCHAR(255) | Customer's first name.                         |
| `cst_lastname`    | VARCHAR(255) | Customer's last name.                          |
| `cst_marital_status`| VARCHAR(50)  | Customer's marital status (e.g., Single, Married).|
| `cst_gndr`        | VARCHAR(10)  | Customer's gender.                             |
| `cst_create_date` | DATETIME     | Date and time when the customer record was created.|

### ➡️ 2. Product Information (`source_crm/prd_info.csv`)

This table stores details about the products offered.

| Column Name   | Data Type     | Description                                     |
|---------------|---------------|-------------------------------------------------|
| `prd_id`      | INT (Primary Key)| Unique identifier for each product.           |
| `prd_key`     | VARCHAR(255) | Unique key for the product (e.g., UUID).       |
| `prd_nm`      | VARCHAR(255) | Name of the product.                           |
| `prd_cost`    | INT       | Cost of the product.                            |
| `prd_line`    | VARCHAR(255) | Product line or category.                       |
| `prd_start_dt`| DATE         | Date when the product became available.         |
| `prd_end_dt`  | DATE         | Date when the product became unavailable (if applicable).|

### ➡️ 3. Sales Details (`source_crm/sales_details.csv`)

This table records individual sales transactions.

| Column Name   | Data Type     | Description                                     |
|---------------|---------------|-------------------------------------------------|
| `sls_ord_num` | INT (Primary Key)| Unique identifier for each sales order.       |
| `sls_prd_key` | VARCHAR(255) | Foreign Key referencing the `Product Information` table.   |
| `sls_cust_id` | INT         | Foreign Key referencing the `Customer Information` table.  |
| `sls_order_dt`| DATE         | Date of the sales order.                        |
| `sls_ship_dt` | DATE         | Date when the order was shipped.                |
| `sls_due_dt`  | DATE         | Due date for the order.                         |
| `sls_sales`   | INT       | Total sales amount for the order.               |
| `sls_quantity`| INT         | Quantity of products sold in the order.         |
| `sls_price`   | INT       | Price per unit of the product at the time of sale.|

### ➡️ 4. Customer Extra Details (`source_erp/CUST_AZ12.csv `)

This table stores additional customer details.

| Column Name | Data Type     | Description                                     |
|-------------|---------------|-------------------------------------------------|
| `CID`       | INT (Primary Key)| Foreign Key referencing `Customer Information` table.  |
| `BDATE`     | DATE         | Customer's birth date.                          |
| `GEN`       | VARCHAR(10)  | Customer's gender (can be redundant with `cst_gndr`).|

### ➡️ 5. Location (`source_erp/LOC_A101.csv`)

This table stores customer location information.

| Column Name | Data Type     | Description                                     |
|-------------|---------------|-------------------------------------------------|
| `CID`       | INT (Primary Key)| Foreign Key referencing `Customer Information` table.  |
| `CNTRY`     | VARCHAR(255) | Customer's country.                             |

### ➡️ 6. Category (`source_erp/PX_CAT_G1V2.csv`)

This table categorizes products.

| Column Name | Data Type     | Description                                     |
|-------------|---------------|-------------------------------------------------|
| `ID`        | INT (Primary Key)| Unique identifier for each category.           |
| `CAT`       | VARCHAR(255) | Main category name.                            |
| `SUBCAT`    | VARCHAR(255) | Subcategory name.                               |
| `MAINTENANCE`| VARCHAR(255) | Maintenance information or notes about the category. |

---

##🪴  Relationships

🔹 `Sales Details` has a foreign key `sls_prd_key` referencing its analog `prd_key` in the `Product Info` (one-to-many).

🔹  `Sales Details` has a foreign key `sls_cust_id` referencing its analog `cst_id` in the Customer Info` (one-to-many).

🔹  `Customer Extra Details` has a foreign key `CID` referencing its analog `cst_id` in the `Customer Info` (one-to-one).

🔹  `Location` has a foreign key `CID` referencing its analog `cst_id` in the `Customer Info` (one-to-one).

## 📟 Notes

🔹  Consider using universally unique identifiers (UUIDs) for `cst_key` and `prd_key` for better scalability and distributed systems.

🔹   The `GEN` column in `Customer Extra Details` might be redundant if `cst_gndr` in `Customer Info` is already present.  Consider removing the redundant column.
  
🔹  Data types should be chosen appropriately based on the expected data and database system being used.
