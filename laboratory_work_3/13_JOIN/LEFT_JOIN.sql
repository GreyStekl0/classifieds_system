SELECT * FROM "Users"
LEFT JOIN "announcements"
ON "Users".id = "announcements".owner_id;