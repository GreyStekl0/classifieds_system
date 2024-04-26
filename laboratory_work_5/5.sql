-- Создание пользователя
CREATE USER Admin WITH PASSWORD '123';

-- Создание роли с полным доступом к БД
CREATE ROLE full_access_role;

-- Назначение всех привилегий на базу данных для роли
GRANT ALL PRIVILEGES ON DATABASE postgres TO full_access_role;

-- Присвоение роли пользователю
GRANT full_access_role TO Admin;
ALTER ROLE admin CREATEROLE;
GRANT read_role TO admin WITH ADMIN OPTION;