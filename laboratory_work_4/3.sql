CREATE VIEW UsersWithAnnouncements_2 AS
SELECT "Users".name, COUNT(announcements.id) AS announcements_count
FROM "Users"
         LEFT JOIN announcements ON "Users".id = announcements.owner_id
GROUP BY "Users".name;