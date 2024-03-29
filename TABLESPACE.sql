--Query to check the used and free space in a particular TABLESPACE

SELECT USED.TABLESPACE_NAME, USED.USED_BYTES AS "USED SPACE(IN GB)",  FREE.FREE_BYTES AS "FREE SPACE(IN GB)"
FROM
(SELECT TABLESPACE_NAME,TO_CHAR(SUM(NVL(BYTES,0))/1024/1024/1024, '99,999,990.99') AS USED_BYTES FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'SMALL' GROUP BY TABLESPACE_NAME) USED
INNER JOIN
(SELECT TABLESPACE_NAME,TO_CHAR(SUM(NVL(BYTES,0))/1024/1024/1024, '99,999,990.99') AS FREE_BYTES FROM  DBA_FREE_SPACE WHERE TABLESPACE_NAME = 'SMALL' GROUP BY TABLESPACE_NAME) FREE
ON (USED.TABLESPACE_NAME = FREE.TABLESPACE_NAME);

--Output:
TABLESPACE_NAME			USED SPACE(IN GB) 	FREE SPACE(IN GB)
EEM_DATA	        	0.00	         	17.00

--TABLESPACE QUOTAS AND USER TABLESPACES
SELECT * FROM USER_TABLESPACES WHERE TABLESPACE_NAME = 'SMALL';

SELECT * FROM USER_TS_QUOTAS;