-- Запрет просмотра таблицы
REVOKE SELECT ON category FROM "user";

-- Запрет просмотра столбца
REVOKE SELECT (email) ON users FROM "user";

SELECT rolname FROM pg_roles WHERE oid IN (
    SELECT member FROM pg_auth_members WHERE roleid = (
        SELECT oid FROM pg_roles WHERE rolname = 'user'
    )
);

-- Attempt to SELECT from the category table as "user"
SET ROLE "user";
SELECT * FROM category;
RESET ROLE;

-- Attempt to SELECT the email column from the users table as "user"
SET ROLE "user";
SELECT email FROM users;
RESET ROLE;