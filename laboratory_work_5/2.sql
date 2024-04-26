-- Создание ролей
CREATE ROLE read_role;
CREATE ROLE insert_role;
CREATE ROLE update_role;
CREATE ROLE delete_role;

-- Назначение привилегий
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_role;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert_role;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update_role;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete_role;