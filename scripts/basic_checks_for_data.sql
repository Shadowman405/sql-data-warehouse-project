--- Check for duplicates
SELECT sls_ord_num, COUNT(*)
FROM DataWareHouse.bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1 OR sls_ord_num IS NULL

--- Check for unwanted Spaces
SELECT sls_prd_key
FROM DataWareHouse.bronze.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key)

--- Data Standartization & Consistency
SELECT DISTINCT prd_line
FROM DataWareHouse.bronze.crm_prd_info


--- Check for nulls or negative numbers
SELECT sls_price
FROM DataWareHouse.bronze.crm_sales_details
WHERE sls_price < 0 OR sls_price IS NULL

--- Check invalid dates 
SELECT *
FROM DataWareHouse.bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt


--- Check for invalid dates
SELECT NULLIF(sls_due_dt, 0) as sls_due_dt
FROM DataWareHouse.bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) !=8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101


--- Check for invalid dates
SELECT *
FROM DataWareHouse.bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

