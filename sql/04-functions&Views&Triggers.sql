----------------------------------------------------
--------------------FUNCTIONS-----------------------
----------------------------------------------------

CREATE OR ALTER FUNCTION ian.f_avb_emp_by_dpt
(
	@p_req_dpt VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
	SELECT e.emp_id, emp_fst_nam, emp_lst_nam, emp_dpt
	FROM ian.t_emp e
	INNER JOIN ian.t_emp_dtl ed
	ON e.emp_id = ed.emp_id
	WHERE emp_dpt = @p_req_dpt
)

----------------------------------------------------
----------------------VIEWS-------------------------
----------------------------------------------------

CREATE OR ALTER VIEW ian.v_emp_inf
AS
SELECT emp_fst_nam, emp_lst_nam, emp_dob, emp_loc, 
CASE 
	WHEN is_mgr = 0 THEN 'NOT Manager'
	ELSE 'MANAGER' 
END AS is_mgr,
emp_dpt, job_ttl,
CASE 
	WHEN emp_sta = 1 THEN 'Available' 
	ELSE 'Busy' 
END AS emp_sta
FROM ian.t_emp e
INNER JOIN ian.t_emp_dtl ed
ON e.emp_id = ed.emp_id