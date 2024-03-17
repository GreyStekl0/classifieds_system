INSERT INTO "NewUsers"
SELECT * FROM "Users"
WHERE id > 1;