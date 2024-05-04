--1--

SELECT rolname
FROM pg_roles;

--2--

CREATE ROLE read_role;
CREATE ROLE insert_role;
CREATE ROLE update_role;
CREATE ROLE delete_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_role;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert_role;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update_role;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete_role;

--3--

CREATE USER connected_role WITH PASSWORD '111';
GRANT CONNECT ON DATABASE postgres TO connected_role;
ALTER USER connected_role CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE postgres TO connected_role;

SET ROLE connected_role;
CREATE DATABASE test_db;
RESET ROLE;

SET ROLE connected_role;
drop database test_db;
RESET ROLE;

--4--
ALTER USER connected_role WITH PASSWORD '222';
ALTER USER connected_role VALID UNTIL '2022-12-31';

--5--
create role Admin superuser;

--6,7--
SET ROLE admin;
CREATE USER "user";
GRANT read_role TO "user";
REVOKE "read_role" FROM "user";
GRANT SELECT (name, phone_number, email) ON "Users" TO "user";
REVOKE SELECT (id) ON public."Users" FROM "user";

SET ROLE "user";
SELECT name
FROM "Users";
RESET ROLE;

--8--

CREATE USER Manager;
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA public TO Manager;

SET ROLE manager;
SELECT * FROM "Users";
DELETE FROM announcements where  id=3;
RESET ROLE;



--9--
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM manager;
DROP USER manager;

--10--
CREATE GROUP managers;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO managers;

--11--
CREATE USER manager;
GRANT managers TO manager;

--12--
CREATE USER test_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO test_user;



