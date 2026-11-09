----------------------------------------------------
----------------------TESTS-------------------------
----------------------------------------------------

SELECT * FROM ian.f_avb_emp_by_dpt('dms')

EXEC ian.s_asn_emp_tsk
	@p_tsk_id = 1;

	SELECT * FROM ian.t_tsk_emp

-- TO DO LIST

-- Does task exist
-- is status valid?
-- is task already complete
-- recalculate availablity for emps
-- when creating the task, insert outstanding and current date in task status table
-- when assigning the first emp, also isert in progress and current date in task status table

-- if new status = 'hold' unassign all employees and recalculate availabilty
-- if status = 'complete' unassign all employees and


