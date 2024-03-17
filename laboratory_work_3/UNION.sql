SELECT * FROM "Users"
WHERE id > 1

UNION

SELECT * FROM "NewUsers"
WHERE id > 3;