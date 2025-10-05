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
