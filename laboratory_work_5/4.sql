-- Изменение пароля пользователя
ALTER USER connected_role WITH PASSWORD '222';

-- Установка срока действия пароля
ALTER USER connected_role VALID UNTIL '2025-12-31';

SELECT rolname, rolvaliduntil
FROM pg_roles
WHERE rolname = 'connected_role';