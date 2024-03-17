SELECT *
FROM "Users"
FULL JOIN "announcements"
ON "Users".id = "announcements".owner_id;