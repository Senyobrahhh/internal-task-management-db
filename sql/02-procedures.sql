----------------------------------------
--------------PROCEDURES----------------
----------------------------------------

-- Insert Employees

CREATE PROCEDURE ian.s_ins_emp
(
	@p_emp_fst_nam VARCHAR(100),
	@p_emp_Lst_Nam VARCHAR(100),
	@p_emp_dob DATE,
	@p_emp_loc VARCHAR(20),
	@p_is_mgr BIT,
	@p_emp_dep VARCHAR(50),
	@p_job_ttl VARCHAR(50),
	@p_res VARCHAR(50) OUTPUT
)
AS
BEGIN
	BEGIN TRANSACTION
END