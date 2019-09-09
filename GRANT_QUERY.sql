--hierarchical query:	**********
--To list down all the roles given to a user and the roles given to those roles and privs given to those roles and so on.
SELECT
  LPAD(' ', 2*LEVEL) || GRANTED_ROLE "USER, HIS ROLES AND PRIVILEGES"
FROM
  (
  /* THE USERS */
    SELECT 
      NULL     GRANTEE, 
      USERNAME GRANTED_ROLE
    FROM 
      DBA_USERS
    WHERE
      USERNAME LIKE UPPER('USER_NAME')
  /* THE ROLES TO ROLES RELATIONS */ 
  UNION
    SELECT 
      GRANTEE,
      GRANTED_ROLE
    FROM
      DBA_ROLE_PRIVS
  /* THE ROLES TO PRIVILEGE RELATIONS */ 
  UNION
    SELECT
      GRANTEE,
      PRIVILEGE
    FROM
      DBA_SYS_PRIVS
  /*UNION 
	SELECT 
		GRANTEE, 
		PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME
	FROM
		DBA_TAB_PRIVS */ --LISTING DOWN THE PRIVIELGES ON OTHER SCHEMA OBJECTS
   )
START WITH GRANTEE IS NULL
CONNECT BY GRANTEE = PRIOR GRANTED_ROLE;