SELECT * FROM "Users"
RIGHT JOIN "announcements"
ON "Users".id = "announcements".owner_id;