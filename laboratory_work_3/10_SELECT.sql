SELECT *
FROM "Users"
WHERE id = (
    SELECT MAX(id)
    FROM "Users"
);