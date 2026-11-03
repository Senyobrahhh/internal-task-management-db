----------------------------------------
--------------SEED-DATA-----------------
----------------------------------------

-- Employee 1

DECLARE @p_res_out VARCHAR(250);
EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'Enyo',
	@p_emp_lst_nam = 'Chorbadzhiyski',
	@p_emp_dob = '20050701',
	@p_emp_loc = 'stz',
	@p_is_mgr = 0,
	@p_emp_dpt = 'dms',
	@p_job_ttl = 'db dev',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

-- Employee 2

DECLARE @p_res_out VARCHAR(250);
EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'George',
	@p_emp_lst_nam = 'Orwell',
	@p_emp_dob = '19500121',
	@p_emp_loc = 'plovdiv',
	@p_is_mgr = 1,
	@p_emp_dpt = 'follow up',
	@p_job_ttl = 'db admin',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

-- Employee 3

DECLARE @p_res_out VARCHAR(250);
EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'Simon',
	@p_emp_lst_nam = 'Cowell',
	@p_emp_dob = '19591007',
	@p_emp_loc = 'stz',
	@p_is_mgr = 0,
	@p_emp_dpt = 'ivhc',
	@p_job_ttl = 'support',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

SELECT * FROM ian.t_emp e INNER JOIN ian.t_emp_dtl ed ON e.emp_id = ed.emp_id

TRUNCATE TABLE ian.t_emp_dtl;
TRUNCATE TABLE ian.t_emp;

-- Task 1

DECLARE @p_res_out VARCHAR(250);
EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Fix missing records in the database',
    --@p_tsk_pri = 'high',
    --@p_tsk_dsc = N'Investigate why there are missing records',
    @p_tsk_dpt = 'support',
    @p_tsk_loc = 'stz',
    --@p_tsk_not = N'Have Fun! :)',
    @p_res = @p_res_out OUTPUT;

SELECT * FROM ian.t_tsk t INNER JOIN ian.t_tsk_dtl td ON t.tsk_id = td.tsk_id

TRUNCATE TABLE ian.t_tsk_dtl;
TRUNCATE TABLE ian.t_tsk;