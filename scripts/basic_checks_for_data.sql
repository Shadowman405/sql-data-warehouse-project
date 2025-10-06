--- Check for duplicates
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

--- Check for unwanted Spaces
SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--- Data Standartization & Consistency
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

--- Check for nulls or negative numbers
SELECT prd_cost
FROM DataWareHouse.bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--- Check invalid dates 
SELECT *
FROM DataWareHouse.bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt
