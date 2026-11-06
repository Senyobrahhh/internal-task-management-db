# Internal Task Management Database

A SQL Server and T-SQL learning project for managing employees, tasks, and assignments across departments and offices. The project uses stored procedures, a table-valued function, a view, and a many-to-many assignment table.

**Status: work in progress.** The repository contains development scripts that need the preparation described below before running them as a complete setup.

## Current functionality

| Object | Purpose |
| --- | --- |
| `ian.s_ins_emp` | Creates an employee and their details inside a transaction. Returns a message through `@p_res OUTPUT`. |
| `ian.s_ins_tsk` | Creates a task and its details inside a transaction, with an initial status of `outstanding`. |
| `ian.s_asn_emp_tsk` | Selects the available employee with the lowest ID in the required department and office, excluding employees already assigned to that task. |
| `ian.f_avb_emp_by_dpt` | Returns employees in a specified department, including their availability. The caller must filter `emp_sta = 1` to get only available employees. |
| `ian.v_emp_inf` | Displays employee names, birth dates, offices, departments, job titles, manager flags, and availability labels. |

Assignment changes the task status to `in progress` and records its start time if it is still `NULL`. An employee is marked busy when their assignment count reaches three unfinished tasks. This count includes tasks on hold.

Task creation uses `normal` priority when the priority parameter is omitted or passed as `NULL`. This behavior is implemented in the procedure; it is not a table default.

## Repository contents

| File | Contents |
| --- | --- |
| [sql/01-schema-and-tables.sql](sql/01-schema-and-tables.sql) | Schema, tables, and check constraints. |
| [sql/02-procedures.sql](sql/02-procedures.sql) | Employee creation, task creation, and assignment procedures. |
| [sql/03_seed_data.sql](sql/03_seed_data.sql) | Sample calls for 15 employees and 15 tasks. |
| [sql/04-functions&Views&Triggers.sql](sql/04-functions&Views&Triggers.sql) | Department function and employee information view. The triggers section is currently empty. |
| [sql/05-tests.sql](sql/05-tests.sql) | Manual function and assignment examples. |
| [docs/rdb.drawio](docs/rdb.drawio) | Database design diagram. |
| [docs/Task_Internal_System.docx](docs/Task_Internal_System.docx) | Project task document. |

## Data model

All database objects use the `ian` schema.

| Table | Stores | Key |
| --- | --- | --- |
| `t_emp` | Employee names and birth dates. | Identity primary key: `emp_id`. |
| `t_emp_dtl` | Office, department, job title, manager flag, and availability. | Primary key: `emp_id`. |
| `t_tsk` | Task title, priority, and status. | Identity primary key: `tsk_id`. |
| `t_tsk_dtl` | Description, dates, department, office, time spent, and notes. | Uses `tsk_id`; the current script does not declare a primary key on this table. |
| `t_tsk_emp` | Employee-to-task assignments. | Composite primary key: `(tsk_id, emp_id)`. |

The assignment table supports many-to-many relationships: an employee can work on multiple tasks, and a task can have multiple employees. Its composite key prevents duplicate employee/task pairs.

Foreign key constraints are intentionally omitted in this version. Relationships are represented through shared IDs and joins, so the database does not enforce the existence of referenced employees or tasks. Details tables are intended to hold one row per employee or task; task-detail uniqueness still needs to be enforced.

### Allowed values

| Field | Values |
| --- | --- |
| Task priority | `high`, `normal`, `low` |
| Task status | `outstanding`, `in progress`, `complete`, `hold` |
| Department | `service plan`, `ivhc`, `follow up`, `dms`, `support` |
| Office | `plovdiv`, `stz` |
| Job title | `web dev`, `db dev`, `support`, `db admin` |
| Employee availability | `1` = available; `0` = busy |
| Manager flag | `1` = manager; `0` = not a manager |

## Setup

Use SQL Server with support for `CREATE OR ALTER` and SQL Server Management Studio (SSMS).

### Prepare the development scripts

Before executing entire files:

1. In `01-schema-and-tables.sql`, remove or comment out the two `DROP TABLE` statements.
2. In `02-procedures.sql`, remove or comment out the unfinished `CREATE OR ALTER PROCEDURE ian.s_` declaration at the end.
3. In `02-procedures.sql` and `04-functions&Views&Triggers.sql`, put `GO` between separate procedure, function, and view definitions so each definition has its own batch.
4. In `03_seed_data.sql`, remove or comment out the `TRUNCATE TABLE` statements, which clear the inserted data. Keep only one declaration of `@p_res_out` in a batch, or separate the employee and task sections with `GO`.

### Run order

Create an empty test database, select it in SSMS, and execute the prepared scripts in this order:

1. `sql/01-schema-and-tables.sql`
2. `sql/04-functions&Views&Triggers.sql`
3. `sql/02-procedures.sql`
4. `sql/03_seed_data.sql`

The function is created before the assignment procedure that uses it. The filenames do not currently reflect this dependency order.

Run the examples in `sql/05-tests.sql` individually after checking the task IDs. Its assignment example changes data.

The setup and seed scripts are not designed for repeated execution against an existing database. Employee creation rejects an existing first-name/last-name pair, while repeated task creation adds another task.

## Usage examples

Run these after completing setup.

### Create an employee

```sql
DECLARE @p_res_out VARCHAR(250);

EXEC ian.s_ins_emp
    @p_emp_fst_nam = 'Demo',
    @p_emp_lst_nam = 'Employee',
    @p_emp_dob = '20000115',
    @p_emp_loc = 'stz',
    @p_is_mgr = 0,
    @p_emp_dpt = 'support',
    @p_job_ttl = 'db dev',
    @p_emp_sta = 1,
    @p_res = @p_res_out OUTPUT;

SELECT @p_res_out AS result;
GO
```

### Create a task

This example uses the procedure's default priority behavior. Start and end dates remain `NULL` when the task is created.

```sql
DECLARE @p_res_out VARCHAR(250);

EXEC ian.s_ins_tsk
    @p_tsk_ttl = N'Review support report query',
    @p_tsk_dsc = N'Investigate missing records in the monthly support report.',
    @p_tsk_dpt = 'support',
    @p_tsk_loc = 'stz',
    @p_tsk_not = N'Check joins and date filters.',
    @p_res = @p_res_out OUTPUT;

SELECT @p_res_out AS result;
GO
```

### Inspect employees and tasks

```sql
SELECT *
FROM ian.v_emp_inf;

SELECT *
FROM ian.f_avb_emp_by_dpt('support')
WHERE emp_sta = 1
  AND emp_loc = 'stz';

SELECT tsk_id, tsk_ttl, tsk_sta
FROM ian.t_tsk
ORDER BY tsk_id;
```

### Assign an employee

Replace `1` with the existing task ID you want to assign.

```sql
EXEC ian.s_asn_emp_tsk
    @p_tsk_id = 1;

SELECT tsk_id, emp_id
FROM ian.t_tsk_emp;
```

Each call adds one eligible employee to the task. Missing tasks, completed tasks, and a lack of eligible employees raise errors.

## Current limitations and next steps

- Finish task-status changes, completion dates, and employee-availability recalculation when assignments end.
- Add task-status history and reporting for time spent in each status.
- Implement archiving of completed tasks.
- Enforce one details row per task and validate missing related records.
- Make assignment changes atomic and protect employee selection and capacity checks against simultaneous calls.
- Replace name-based employee duplicate detection with a reliable identifier.
- Turn the development scripts into a repeatable setup and add automated tests. The current test file contains manual examples only.
