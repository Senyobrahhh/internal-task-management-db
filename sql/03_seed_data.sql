----------------------------------------
--------------SEED-DATA-----------------
----------------------------------------

--*--*--*--*--*--*--*--*--*--*--*--*--*--
---*--*--*--*--EMPLOYEES--*--*--*--*--*--
--*--*--*--*--*--*--*--*--*--*--*--*--*--

-- EMPLOYEES

DECLARE @p_res_out VARCHAR(250);

--DMS

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

EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'Desislava',
	@p_emp_lst_nam = 'Nikolova',
	@p_emp_dob = '19910406',
	@p_emp_loc = 'plovdiv',
	@p_is_mgr = 1,
	@p_emp_dpt = 'dms',
	@p_job_ttl = 'db admin',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Simona',
	@p_emp_lst_nam = 'Pavlova',
	@p_emp_dob = '19970727',
	@p_emp_loc = 'plovdiv',
	@p_is_mgr = 0,
    @p_emp_dpt = 'dms',
	@p_job_ttl = 'web dev',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;


-- SERVICE PLAN

EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'Aleksandar',
	@p_emp_lst_nam = 'Dimitrov',
	@p_emp_dob = '19890314',
	@p_emp_loc = 'stz',
	@p_is_mgr = 1,
	@p_emp_dpt = 'service plan',
	@p_job_ttl = 'db admin',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
	@p_emp_fst_nam = 'Elena',
	@p_emp_lst_nam = 'Stoyanova',
	@p_emp_dob = '19970622',
	@p_emp_loc = 'plovdiv',
	@p_is_mgr = 0,
	@p_emp_dpt = 'service plan',
	@p_job_ttl = 'web dev',
	@p_emp_sta = 1,
	@p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Nikolay',
    @p_emp_lst_nam = 'Todorov',
    @p_emp_dob = '19950908',
    @p_emp_loc = 'stz',
    @p_is_mgr = 0,
    @p_emp_dpt = 'service plan',
    @p_job_ttl = 'db dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

-- IVHC

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Petar',
    @p_emp_lst_nam = 'Kolev',
    @p_emp_dob = '19880417',
    @p_emp_loc = 'plovdiv',
    @p_is_mgr = 1,
    @p_emp_dpt = 'ivhc',
    @p_job_ttl = 'db admin',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Viktoria',
    @p_emp_lst_nam = 'Ilieva',
    @p_emp_dob = '19991103',
    @p_emp_loc = 'stz',
    @p_is_mgr = 0,
    @p_emp_dpt = 'ivhc',
    @p_job_ttl = 'db dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Stefan',
    @p_emp_lst_nam = 'Georgiev',
    @p_emp_dob = '19960825',
    @p_emp_loc = 'plovdiv',
    @p_is_mgr = 0,
    @p_emp_dpt = 'ivhc',
    @p_job_ttl = 'web dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

-- FOLLOW UP

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Martin',
    @p_emp_lst_nam = 'Hristov',
    @p_emp_dob = '19900212',
    @p_emp_loc = 'stz',
    @p_is_mgr = 1,
    @p_emp_dpt = 'follow up',
    @p_job_ttl = 'db admin',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Gabriela',
    @p_emp_lst_nam = 'Marinova',
    @p_emp_dob = '19980519',
    @p_emp_loc = 'plovdiv',
    @p_is_mgr = 0,
    @p_emp_dpt = 'follow up',
    @p_job_ttl = 'web dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Dimitar',
    @p_emp_lst_nam = 'Vasilev',
    @p_emp_dob = '19941030',
    @p_emp_loc = 'stz',
    @p_is_mgr = 0,
    @p_emp_dpt = 'follow up',
    @p_job_ttl = 'db dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

-- SUPPORT

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Radoslav',
    @p_emp_lst_nam = 'Ivanov',
    @p_emp_dob = '19861209',
    @p_emp_loc = 'stz',
    @p_is_mgr = 1,
    @p_emp_dpt = 'support',
    @p_job_ttl = 'support',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Teodora',
    @p_emp_lst_nam = 'Dimitrova',
    @p_emp_dob = '19980916',
    @p_emp_loc = 'plovdiv',
    @p_is_mgr = 0,
    @p_emp_dpt = 'support',
    @p_job_ttl = 'support',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Borislav',
    @p_emp_lst_nam = 'Stanev',
    @p_emp_dob = '19950604',
    @p_emp_loc = 'stz',
    @p_is_mgr = 0,
    @p_emp_dpt = 'support',
    @p_job_ttl = 'db dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

SELECT * FROM ian.t_emp e INNER JOIN ian.t_emp_dtl ed ON e.emp_id = ed.emp_id

TRUNCATE TABLE ian.t_emp_dtl;
TRUNCATE TABLE ian.t_emp;

--*--*--*--*--*--*--*--*--*--*--*--*--*--
--*--*--*--*--*--TASKS--*--*--*--*--*--*-
--*--*--*--*--*--*--*--*--*--*--*--*--*--

DECLARE @p_res_out VARCHAR(250);

-- SERVICE PLAN

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Fix service plan renewal dates',
    @p_tsk_pri = 'high',
    @p_tsk_dsc = N'Correct renewal dates that are calculated one month too early.',
    @p_tsk_dpt = 'service plan',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Test plans created at the end of the month.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Add service plan form validation',
    @p_tsk_pri = 'normal',
    @p_tsk_dsc = N'Validate required customer and vehicle fields before saving a plan.',
    @p_tsk_dpt = 'service plan',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = NULL,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Create service plan summary report',
    @p_tsk_pri = 'low',
    @p_tsk_dsc = N'Create a report showing active plans and upcoming renewals.',
    @p_tsk_dpt = 'service plan',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Include a department filter.',
    @p_res = @p_res_out OUTPUT;

-- IVHC

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Fix inspection save failure',
    @p_tsk_pri = 'high',
    @p_tsk_dsc = N'Investigate why inspections containing multiple defects fail to save.',
    @p_tsk_dpt = 'ivhc',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = N'Reproduce using test inspection data.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Investigate missing inspection results',
    @p_tsk_pri = 'normal',
    @p_tsk_dsc = N'Find why some completed inspections are missing from the results report.',
    @p_tsk_dpt = 'ivhc',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Check joins and status filters.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Improve inspection form hints',
    @p_tsk_pri = 'low',
    @p_tsk_dsc = N'Add clear instructions beside optional inspection fields.',
    @p_tsk_dpt = 'ivhc',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = NULL,
    @p_res = @p_res_out OUTPUT;

-- FOLLOW UP

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Fix duplicate customer reminders',
    @p_tsk_pri = 'high',
    @p_tsk_dsc = N'Prevent the same follow-up reminder from being generated twice.',
    @p_tsk_dpt = 'follow up',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Check the scheduled reminder process.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Add overdue follow-up filter',
    @p_tsk_pri = 'normal',
    @p_tsk_dsc = N'Allow users to filter the dashboard to show only overdue follow-ups.',
    @p_tsk_dpt = 'follow up',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = NULL,
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Create weekly follow-up report',
    @p_tsk_pri = 'low',
    @p_tsk_dsc = N'Summarize completed and outstanding follow-ups for the selected week.',
    @p_tsk_dpt = 'follow up',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Include totals for each employee.',
    @p_res = @p_res_out OUTPUT;

-- DMS

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Fix customer synchronization failure',
    @p_tsk_pri = 'high',
    @p_tsk_dsc = N'Investigate customer records that fail during synchronization.',
    @p_tsk_dpt = 'dms',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = N'Check records with missing optional fields.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Optimize vehicle search query',
    @p_tsk_pri = 'normal',
    @p_tsk_dsc = N'Reduce execution time when searching vehicles by registration number.',
    @p_tsk_dpt = 'dms',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Compare execution plans before and after changes.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Improve synchronization error messages',
    @p_tsk_pri = 'low',
    @p_tsk_dsc = N'Display a useful explanation when a synchronization operation fails.',
    @p_tsk_dpt = 'dms',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = NULL,
    @p_res = @p_res_out OUTPUT;

-- SUPPORT

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Investigate employee login failures',
    @p_tsk_pri = 'high',
    @p_tsk_dsc = N'Identify why some employees cannot sign in after resetting their passwords.',
    @p_tsk_dpt = 'support',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Use test accounts when reproducing the issue.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Investigate slow support report',
    @p_tsk_pri = 'normal',
    @p_tsk_dsc = N'Find why the monthly support report takes too long to load.',
    @p_tsk_dpt = 'support',
    @p_tsk_loc = 'plovdiv',
    @p_tsk_not = N'Record execution time before making changes.',
    @p_res = @p_res_out OUTPUT;

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Update database troubleshooting guide',
    @p_tsk_pri = 'low',
    @p_tsk_dsc = N'Document common database connection errors and their resolution steps.',
    @p_tsk_dpt = 'support',
    @p_tsk_loc = 'stz',
    @p_tsk_not = NULL,
    @p_res = @p_res_out OUTPUT;

SELECT * FROM ian.t_tsk t INNER JOIN ian.t_tsk_dtl td ON t.tsk_id = td.tsk_id

TRUNCATE TABLE ian.t_tsk_dtl;
TRUNCATE TABLE ian.t_tsk;