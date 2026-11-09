----------------------------------------
--------------PROCEDURES----------------
----------------------------------------

----------------------------------------------------------------------------------------------
-- INSERT EMPLOYEES --------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

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

---------------------------------------------------------------------------------------------
-- INSERT TASKS -----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

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

			INSERT INTO ian.t_tsk_sta_hst(tsk_id, tsk_sta, sta_chg_at)  -- NEW
			VALUES (@p_new_tsk_id, 'outstanding', SYSDATETIME())        -- NEW

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
----------------------------------------------------------------------------------------------
-- ASSIGN TASKS  -----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ian.s_asn_emp_tsk
(
	@p_tsk_id INT
)
AS
BEGIN

	DECLARE @p_avb_emp_fst_nam VARCHAR(100), @p_avb_emp_lst_nam VARCHAR(100)


	-- VALUES

	DECLARE @p_req_dpt VARCHAR(50) =
	(
		SELECT td.tsk_dpt
		FROM ian.t_tsk t
		INNER JOIN ian.t_tsk_dtl td
		ON t.tsk_id = td.tsk_id
		WHERE t.tsk_id = @p_tsk_id
	)

	DECLARE @p_req_loc VARCHAR(20) = 
	(
		SELECT td.tsk_loc
		FROM ian.t_tsk t
		INNER JOIN ian.t_tsk_dtl td
		ON t.tsk_id = td.tsk_id
		WHERE t.tsk_id = @p_tsk_id
	)

	DECLARE @p_avb_emp INT = 
	(
		SELECT TOP 1 emp_id
		FROM ian.f_avb_emp_by_dpt(@p_req_dpt) e
		WHERE emp_loc = @p_req_loc
		AND emp_sta = 1
		AND NOT EXISTS
		(
			SELECT 1
			FROM ian.t_tsk_emp te
			WHERE tsk_id = @p_tsk_id
			AND te.emp_id = e.emp_id
		)
		ORDER BY emp_id
	)

	SELECT @p_avb_emp_fst_nam = emp_fst_nam, @p_avb_emp_lst_nam = emp_lst_nam
	FROM ian.t_emp
	WHERE emp_id = @p_avb_emp

	
-- VALIDATION
	
--------------------------	
	IF NOT EXISTS
	(
		SELECT 1 tsk_id
		FROM ian.t_tsk				-- Checks if task exists
		WHERE tsk_id = @p_tsk_id
	) 
	BEGIN
		;THROW 50001, 'Task Not Found!', 1;
	END
--------------------------
	ELSE IF
	(
		SELECT tsk_sta
		FROM ian.t_tsk				-- Checks if task is complete
		WHERE tsk_id = @p_tsk_id
	) = 'complete'
	BEGIN 
		;THROW 50001, 'Task Already Complete', 1;
	END
--------------------------
	ELSE IF @p_avb_emp IS NULL 
	BEGIN
		;THROW 50001, 'No Available Employee!', 1;	-- Checks if there is an available employee
	END
--------------------------
	ELSE
	BEGIN
		INSERT INTO ian.t_tsk_emp(tsk_id, emp_id)
		VALUES(@p_tsk_id, @p_avb_emp)

		IF
		(
			SELECT COUNT(*)			-- Checks if an employee has 3 or more tasks and assigns the 'busy status'/'0'
			FROM ian.t_tsk_emp te
			INNER JOIN ian.t_tsk t
			ON te.tsk_id = t.tsk_id
			WHERE emp_id = @p_avb_emp
			AND tsk_sta <> 'complete'
		) >= 3
		BEGIN
			UPDATE ian.t_emp_dtl
			SET emp_sta = 0
			WHERE emp_id = @p_avb_emp
		END

		UPDATE ian.t_tsk
		SET tsk_sta = 'in progress' -- update the tsk status to busy
		WHERE tsk_id = @p_tsk_id

		IF
		(
			SELECT COUNT(emp_id)
			FROM ian.t_tsk_emp
			WHERE tsk_id = @p_tsk_id												-- NEW NEW NEW NEW NEW
		) = 1
		BEGIN
			INSERT INTO ian.t_tsk_sta_hst(tsk_id, tsk_sta, sta_chg_at)
			VALUES (@p_tsk_id, 'in progress', SYSDATETIME())
		END

		UPDATE ian.t_tsk_dtl
		SET tsk_str = SYSDATETIME() -- sets current time to tasks start time
		WHERE tsk_id = @p_tsk_id
		AND tsk_str IS NULL

		PRINT 'Task assigned Successfully to: ' + @p_avb_emp_fst_nam + ' ' + @p_avb_emp_lst_nam
	END

END

-------------------------------------------------------------------------------------------------------
-- Change Status of Task  -----------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ian.s_upd_tsk
(
	@p_tsk_id INT,
	@p_tsk_new_sta VARCHAR(15)
)
AS
BEGIN

	DECLARE @p_aff_emp TABLE
	(
		emp_id INT
	);

	INSERT INTO @p_aff_emp(emp_id)
	SELECT emp_id
	FROM ian.t_tsk_emp
	WHERE tsk_id = @p_tsk_id


	IF NOT EXISTS
	(
		SELECT 1 tsk_id
		FROM ian.t_tsk									
		WHERE tsk_id = @p_tsk_id
	) 
	BEGIN
		;THROW 50001, 'Task Not Found!', 1;
	END

	ELSE IF @p_tsk_new_sta IS NULL
		OR @p_tsk_new_sta NOT IN ('outstanding', 'in progress', 'hold', 'complete')
	BEGIN
		;THROW 50001, 'Status Unrecognised', 1;
	END

	ELSE IF
	(
		SELECT tsk_sta
		FROM ian.t_tsk
		WHERE tsk_id = @p_tsk_id
	) = 'complete'
	BEGIN
		;THROW 50001, 'Task Already Completed', 1;
	END

	ELSE IF
	(
		SELECT tsk_sta
		FROM ian.t_tsk
		WHERE tsk_id = @p_tsk_id
	) = @p_tsk_new_sta
	BEGIN
		;THROW 50001, 'Task is already the assigned status', 1;
	END

	ELSE
	BEGIN
		
		IF @p_tsk_new_sta = 'outstanding'
		BEGIN
			;THROW 50001, 'Status Outstanding can only be assigned systematically when the task is created.', 1;
		END

		ELSE IF @p_tsk_new_sta = 'in progress'
		BEGIN
			;THROW 50001, 'In Order to start the task again, please assign an employee', 1;
		END

		ELSE IF @p_tsk_new_sta = 'hold'
		BEGIN
			
			DELETE FROM ian.t_tsk_emp
			WHERE tsk_id = @p_tsk_id

			UPDATE ed
			SET emp_sta = 
				CASE
					WHEN
					(
						SELECT COUNT(*)
						FROM ian.t_tsk_emp te
						WHERE te.emp_id = ed.emp_id
					) < 3 THEN 1
					ELSE 0
				END
			FROM ian.t_emp_dtl ed
			WHERE ed.emp_id IN
			(
				SELECT emp_id
				FROM @p_aff_emp
			)

			UPDATE ian.t_tsk
			SET tsk_sta = 'hold'
			WHERE tsk_id = @p_tsk_id

			INSERT INTO ian.t_tsk_sta_hst (tsk_id, tsk_sta, sta_chg_at)
			VALUES (@p_tsk_id, 'hold', SYSDATETIME())




		END

		ELSE IF @p_tsk_new_sta = 'complete'
		BEGIN
			
			DELETE FROM ian.t_tsk_emp
			WHERE tsk_id = @p_tsk_id
			
			UPDATE ed
			SET emp_sta = 
				CASE
					WHEN
					(
						SELECT COUNT(*)
						FROM ian.t_tsk_emp te
						WHERE te.emp_id = ed.emp_id
					) < 3 THEN 1
					ELSE 0
				END
			FROM ian.t_emp_dtl ed
			WHERE ed.emp_id IN
			(
				SELECT emp_id
				FROM @p_aff_emp
			)

			UPDATE ian.t_tsk
			SET tsk_sta = 'complete'
			WHERE tsk_id = @p_tsk_id

			UPDATE ian.t_tsk_dtl
			SET tsk_end = SYSDATETIME()
			WHERE tsk_id = @p_tsk_id

			INSERT INTO ian.t_tsk_sta_hst (tsk_id, tsk_sta, sta_chg_at)
			VALUES (@p_tsk_id, 'complete', SYSDATETIME())


		END
	END
END





