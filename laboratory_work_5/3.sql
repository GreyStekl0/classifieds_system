-- Создание пользователя
CREATE USER connected_role WITH PASSWORD '111';

-- Предоставление прав на подключение к базе данных
GRANT CONNECT ON DATABASE postgres TO connected_role;

-- Предоставление прав на создание баз данных
ALTER USER connected_role CREATEDB;

-- Предоставление прав на изменение баз данных
GRANT ALL PRIVILEGES ON DATABASE postgres TO connected_role;

SELECT rolname, rolsuper, rolcreaterole, rolcreatedb, rolcanlogin
FROM pg_roles
WHERE rolname = 'connected_role';