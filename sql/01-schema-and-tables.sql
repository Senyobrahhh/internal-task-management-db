----------------------------------------
---------------SCHEMA-------------------
----------------------------------------

CREATE SCHEMA ian
GO

----------------------------------------
---------------TABLES-------------------
----------------------------------------

-- Task Table

CREATE TABLE ian.t_tsk
(
	tsk_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	tsk_ttl NVARCHAR(200) NOT NULL,
	tsk_pri VARCHAR(10) NOT NULL,
	tsk_sta VARCHAR(15) NOT NULL,

	CONSTRAINT ck_t_tsk_pri
		CHECK(tsk_pri IN ('high', 'normal', 'low')),

	CONSTRAINT ck_t_tsk_sta
		CHECK(tsk_sta IN ('outstanding', 'in progress', 'complete', 'hold'))
);

-- Task Details Table

CREATE TABLE ian.t_tsk_dtl
(
	tsk_id INT NOT NULL,
	tsk_dsc NVARCHAR(500),
	tsk_str DATETIME2(0),
	tsk_end DATETIME2(0),
	tim_spt_hrs INT,
	tsk_not NVARCHAR(500),

	CONSTRAINT pk_t_tsk_dtl
		PRIMARY KEY(tsk_id)

);

-- Employee Table

CREATE TABLE ian.t_emp
(
	emp_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	emp_fst_nam VARCHAR(100) NOT NULL,
	emp_lst_nam VARCHAR(100) NOT NULL,
	emp_dob DATE
);

-- Employees Detail Table

CREATE TABLE ian.t_emp_dtl
(
	emp_id INT NOT NULL,
	emp_loc VARCHAR(20) NOT NULL,
	is_mgr BIT NOT NULL,
	emp_dpt VARCHAR(50) NOT NULL,
	job_ttl VARCHAR(50) NOT NULL,

	CONSTRAINT pk_t_emp_dtl
		PRIMARY KEY(emp_id),

	CONSTRAINT ck_t_emp_dpt
		CHECK(emp_dpt IN ('service plan', 'ivhc', 'follow up', 'dms', 'support')),

	CONSTRAINT ck_t_emp_job_ttl
		CHECK(job_ttl IN ('web dev', 'db dev', 'support', 'db admin')),

	CONSTRAINT ck_t_emp_loc
		CHECK(emp_loc IN ('plovdiv', 'stz'))
);

-- Task Employees Table

CREATE TABLE ian.t_tsk_emp
(
	tsk_id INT NOT NULL,
	emp_id INT NOT NULL,

	CONSTRAINT pk_t_tsk_emp
		PRIMARY KEY(tsk_id, emp_id)

);