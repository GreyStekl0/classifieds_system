SELECT * FROM "Users"
INNER JOIN "announcements"
ON "Users".id = "announcements".owner_id;