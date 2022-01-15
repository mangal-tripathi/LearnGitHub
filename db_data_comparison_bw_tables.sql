SET SERVEROUTPUT ON;
DECLARE
 v_count NUMBER;
 v_sql CLOB;
 TYPE list_values IS
 TABLE OF VARCHAR2(4000);
 column_names list_values := list_values('ARIA_WID', 'ASSIGNMENT_STATUS', 'ASSIGNMENT_WID', 'BRIDGE_TENURE_WID', 'COMPENSATION_WID'
 , 'COMP_PLAN_DERIVED_PROD_WID', 'COMP_PLAN_PROD_WID', 'COST', 'COSTCENTRE_WID', 'COUNTRY_STD_HRS'
 , 'CR_NONGL_ACC_WID', 'CSS_HR_KEYS_WID', 'CTRY_WID', 'DATA_SOURCE', 'EMP_WORK_HRS'
 , 'FY_BEGIN_END_FLG', 'HC_ACC_INT_WID', 'HC_ATTRIBUTE_WID', 'HC_PRODUCT_WID', 'HRI_POSTN_WID'
 , 'IB_CATEGORY', 'JOB_WID', 'LE_WID', 'LOB_WID', 'LOCATION_WID'
 , 'MONTH_WID_LEAD1', 'NUMBER_OF_EMPLOYEES', 'NUMBER_OF_FTE', 'ORGANIZATION_WID', 'PERSON_TYPE'
 , 'PERSON_WID', 'RCODE_WID', 'RECORD_TYPE', 'RESTATEMENT_DT_WID', 'SNAPSHOT_TYPE_WID'
 , 'SUPERVISOR_WID', 'TAG', 'TENURE_CONT_WID', 'TENURE_IN_ORG_WID', 'TENURE_IN_ROLE_WID'
 , 'TENURE_WID', 'TERRITORY_WID', 'TIME_DESC', 'TIME_WID', 'TRUE_MGR_FLG'
 , 'YEARS_WITH_ORACLE');
 l_date_data_type EXCEPTION;
 PRAGMA exception_init ( l_date_data_type, -00904 );
BEGIN
 FOR r IN 1..column_names.count LOOP
 BEGIN
 v_sql := '
 SELECT COUNT(1) FROM A_HC_SNAPSHOT_WEEK_f mis_l 
 JOIN S_HC_SNAPSHOT_WEEK_f M ON M.WEEK_WID = mis_l.WEEK_WID AND M.TIME_DESC = mis_l.TIME_DESC AND mis_l.PERSON_WID = M.PERSON_WID AND mis_l.SUPERVISOR_WID = M.SUPERVISOR_WID
 WHERE mis_l.WEEK_WID = 202220211010 and trim(upper(nvl(to_char(mis_l.'|| column_names(r)|| '),''X'')))!= trim(upper(nvl(to_char(m.'|| column_names(r) || '),''X'')))';
 
EXECUTE IMMEDIATE v_sql INTO v_count;
-- DBMS_OUTPUT.PUT_LINE (v_sql);
 dbms_output.put_line('COLUMN '
 || column_names(r)
 || ' has differences: '
 || v_count);
EXCEPTION
 WHEN l_date_data_type THEN
 NULL;
 END;
 END LOOP;
dbms_output.put_line('v_sql = ' || v_sql);
END;