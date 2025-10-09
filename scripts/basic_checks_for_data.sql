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


--- Check no NULLS or Negative Numbers or Zero, Sales = Qnt * Price
SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price
FROM DataWareHouse.bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
