/*
============================================================================
	SILVER LAYER DATA QUALITY CHECKS
============================================================================
Script Purpose:
	This script performs various quality checks for data consistency, 
	accuracy, and standardization across the 'silver' schema. It 
	includes checks for:
		- Null or duplciate primary keys.
		- Unwanted spaces in string fields.
		- Data standardization and consistency.
		- Invalid date ranges and order.
		- Data consistency between related columns.

	Usage Notes:
		- Run these checks after data loading the Silver Layer.
		- Investigate and resolve any discrepancies found during the checks.
============================================================================
*/

-- ================================================
-- CHECKING silver.crm_cust_info
--=================================================

-- CHECK FOR DUPLICATE OR NULL IDs
-- EXPECTATION: NO RESULTS
SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- CHECK FOR UNWANTED SPACES ON cst_key
-- EXPECTATION: NO RESULTS
SELECT
cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key)

-- CHECK FOR UNWANTED SPACES ON cst_firstname
-- EXPECTATION: NO RESULTS
SELECT
cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- CHECK FOR UNWANTED SPACES ON cst_lastname
-- EXPECTATION: NO RESULTS
SELECT
cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- CHECK MARITAL STATUS
-- EXPECTATION: NO RESULTS
SELECT
cst_id,
cst_marital_status
FROM silver.crm_cust_info
Where cst_marital_status NOT IN ('Single', 'Married', 'n/a')

-- CHECK GENDER
-- EXPECTATION: NO RESULTS
SELECT
cst_id,
cst_gndr
FROM silver.crm_cust_info
Where cst_gndr NOT IN ('Female', 'Male', 'n/a')


-- ================================================
-- CHECKING silver.crm_prd_info
--=================================================

-- CHECK FOR DUPLICATE OR NULL IDs
-- EXPECTATION: NO RESULTS
SELECT
prd_id,
COUNT(*) AS prd_id_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- CHECK THE prd_cost FOR NULLS OR NEGATIVE NUMBERS
-- EXPECTATION: NO RESULTS
SELECT
prd_id,
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- CHECK THE prd_nm FOR UNWANTED SPACES
-- EXPECTATION: NO RESULTS
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- CHECK THE STANDARDIZATION & CONSISTENCY OF prd_line; WHICH WE REDEFINED TO FALL INTO
-- JUST FIVE PRODUCT LINES: MOUNTAIN, ROAD, OTHER SALES, TOURING, n/a
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- CHECK FOR INVALID DATE ISSUES
-- EXPECTATION: NO RESULTS
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt

SELECT * FROM silver.crm_prd_info

-- ================================================
-- CHECKING silver.crm_sales_details
--=================================================

-- CHECK FOR UNWANTED SPACES ON THE SALES ORDER# COLUMN:  sls_ord_num
-- EXPECTATION: NO RESULTS
SELECT sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)


-- CHECK COLUMN: sls_prd_key   FOR ANY  sls_prd_key  THAT ARE NOT IN 
-- THE  crm_prd_info TABLE
-- EXPECTATION: NO RESULTS
SELECT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info )


-- CHECK THE:  sls_cust_id  IN THE SAME WAY AS ABOVE QUERY, CHECKING
-- AGAINST THE TABLE: silver.crm_cust_info  TO MAKE SURE ALL OF OUR
-- sls_cust_id s ARE IN THE silver.crm_cust_info TABLE
-- EXPECTATION: NO RESULTS
SELECT sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info )


-- Now we are going to check for issues with the sls_order_dt
-- The date should be an INT with 8 digits
-- The date should not be 0 or less than 0
-- Date should fall in the range of 19000101  & 20500101
-- EXPECTATION: NO RESULTS
SELECT
sls_ship_dt
FROM silver.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) != 8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101

SELECT sls_ship_dt
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'crm_sales_details'
  AND DATA_TYPE = 'date';


-- Check for invalid dates between order date, ship date, due date
-- EXPECTATION: NO RESULTS
SELECT * FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt OR sls_ship_dt > sls_due_dt


-- Check to make sure that sls_sales = sls_quantity * sls_price and
-- that there are no zeros, NULLs, or negative numbers.
-- EXPECTATION: NO RESULTS
SELECT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales <= 0 
OR sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL




-- ================================================
-- CHECKING silver.erp_cust_az12
--=================================================

-- CHECK TO MAKE SURE THAT ALL cid s ARE IN THE silver.crm_cust_info TABLE
-- EXPECTATION: NO RESULTS
SELECT DISTINCT cid FROM silver.erp_cust_az12
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info);

-- CHECK TO MAKE SURE bdate s WITHIN ACCEPTABLE RANGE
-- EXPECTATION: NO RESULTS ( in this case there are dates out of that 
--     range but are considered considered exceptions - could discuss with 
--     experts and stakeholders about modifying acceptabel range.
SELECT DISTINCT bdate FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'  OR bdate > GETDATE()

-- CHECK TO MAKE SURE gen IS EITHER 'n/a', 'Male', 'Female' 
-- EXPECTATION: NO RESULTS
SELECT gen FROM silver.erp_cust_az12
WHERE gen NOT IN ('n/a', 'Male', 'Female')


-- ================================================
-- CHECKING silver.erp_loc_a101
--=================================================

-- CHECK THE DISTINCT COUNTRY LIST TO CONFIRM STANDARDIZATION
-- EXPECTATIONS: NO RESULTS
SELECT DISTINCT cntry FROM silver.erp_loc_a101
WHERE cntry NOT IN ('n/a', 'Germany', 'United States', 'Australia', 'United Kingdom', 'Canada', 'France')


-- ================================================
-- CHECKING silver.erp_px_cat_g1v2
--=================================================

-- CHECK FOR UNWANTED SPACES
-- EXPECTATION: NO RESULTS
SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
		OR subcat != TRIM(subcat)
		OR maintenance != TRIM(maintenance);

-- CHECK THE cat FOR STANDARDIZATION
SELECT DISTINCT cat FROM silver.erp_px_cat_g1v2
WHERE cat NOT IN ('Accessories', 'Bikes', 'Clothing', 'Components')

-- CHECK subcat FOR STANDARDIZATION ANOMALIES
-- EXPECTATIONS: 37 CURRENT DISTINCT SUBCATEGORIES
SELECT DISTINCT subcat FROM silver.erp_px_cat_g1v2

-- CHECK maintenance FOR STANDARDIZATION TO YES OR NO
-- EXPECTATIONS: NO RESULTS
SELECT DISTINCT maintenance FROM silver.erp_px_cat_g1v2
WHERE maintenance NOT IN ('No', 'Yes')
