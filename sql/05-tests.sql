----------------------------------------------------
----------------------TESTS-------------------------
----------------------------------------------------

SELECT * FROM ian.f_avb_emp_by_dpt('dms')

EXEC ian.s_asn_emp_tsk
	@p_tsk_id = 1;

	SELECT * FROM ian.t_tsk_emp

-- TO DO LIST

-- Does task exist (Complete)
-- is status valid? (Complete)
-- is task already complete (Complete)
-- when creating the task, insert outstanding and current date in task status table (Complete)
-- when assigning the first emp, also isert in progress and current date in task status table (Complete)
-- Is the status already the inserted status (Complete)
-- Insert tsk_end date if status = 'complete' (Complete)
-- if new status = 'hold' unassign all employees and recalculate availabilty
-- if status = 'complete' unassign all employees and recalculate availabilty


