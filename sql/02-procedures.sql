----------------------------------------
--------------PROCEDURES----------------
----------------------------------------

-- INSERT EMPLOYEES --------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ian.s_ins_emp
(
	@p_emp_fst_nam VARCHAR(100),
	@p_emp_lst_nam VARCHAR(100),
	@p_emp_dob DATE,
	@p_emp_loc VARCHAR(20),
	@p_is_mgr BIT,
	@p_emp_dpt VARCHAR(50),
	@p_job_ttl VARCHAR(50),
	@p_emp_sta BIT,
	@p_res VARCHAR(250) OUTPUT
)
AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION

			IF NOT EXISTS
			(
				SELECT 1
				FROM ian.t_emp
				WHERE emp_fst_nam = @p_emp_fst_nam AND emp_lst_nam = @p_emp_lst_nam
			)
			BEGIN

				INSERT INTO ian.t_emp(emp_fst_nam, emp_lst_nam, emp_dob)
				VALUES(@p_emp_fst_nam, @p_emp_lst_nam, @p_emp_dob)

				DECLARE @p_new_emp_id INT = SCOPE_IDENTITY()

				INSERT INTO ian.t_emp_dtl(emp_id ,emp_loc, is_mgr, emp_dpt, job_ttl, emp_sta)
				VALUES(@p_new_emp_id ,@p_emp_loc, @p_is_mgr, @p_emp_dpt, @p_job_ttl, @p_emp_sta)

			END
			ELSE
			BEGIN
				;THROW 50001, 'Employee already exists.', 1;
			END

		COMMIT TRANSACTION

		SELECT @p_res = 'Insertion Of: ' + @p_emp_fst_nam + ' ' + @p_emp_lst_nam + ' was SUCCESSFUL'
		PRINT @p_res

	END TRY


	BEGIN CATCH

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION

		SELECT @p_res = 'Employee Insertion Failed';
		PRINT @p_res;
		THROW

	END CATCH

END

-- INSERT TASKS -----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ian.s_ins_tsk
(
	@p_tsk_ttl NVARCHAR(200),
	@p_tsk_pri VARCHAR(10) = NULL,
	@p_tsk_dsc NVARCHAR(500) = NULL,
	@p_tsk_dpt VARCHAR(50),
	@p_tsk_loc VARCHAR(20),
	@p_tsk_not NVARCHAR(500) = NULL,
	@p_res VARCHAR(250) OUTPUT
)
AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION

			INSERT INTO ian.t_tsk(tsk_ttl, tsk_pri, tsk_sta)
			VALUES (@p_tsk_ttl, ISNULL(@p_tsk_pri, 'normal'), 'outstanding')

			DECLARE @p_new_tsk_id INT = SCOPE_IDENTITY()

			INSERT INTO ian.t_tsk_dtl(tsk_id, tsk_dsc, tsk_str, tsk_end, tsk_dpt, tsk_loc, tim_spt_hrs, tsk_not)
			VALUES (@p_new_tsk_id, @p_tsk_dsc, NULL, NULL, @p_tsk_dpt, @p_tsk_loc, NULL, @p_tsk_not)

		COMMIT TRANSACTION

		SELECT @p_res = 'Task Created Successfully'
		PRINT @p_res
	END TRY

	BEGIN CATCH

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION

		SELECT @p_res = 'Task Insertion Failed'
		PRINT @p_res;
		THROW

	END CATCH
END

-- ASSIGN TASKS  -----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ian.s_asn_emp_tsk
(
	
)
AS
BEGIN
	
END