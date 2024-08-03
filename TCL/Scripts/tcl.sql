SELECT * FROM EMP;

UPDATE EMP
SET SAL = SAL*1.1;

ROLLBACK;

/*COMMIT 을 하고 롤백을 계속 해도 안되기 때문에 신중하게*/
COMMIT;
