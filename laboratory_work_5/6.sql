SET ROLE admin;

-- Создание пользователя
CREATE USER "user" WITH PASSWORD '333';

-- Присвоение роли только для чтения записей из БД
GRANT read_role TO "user";
RESET ROLE;

SELECT r.rolname,
       ARRAY(SELECT b.rolname
             FROM pg_catalog.pg_auth_members m
                      JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
             WHERE m.member = r.oid) as memberof
FROM pg_catalog.pg_roles r
WHERE r.rolname = 'user';