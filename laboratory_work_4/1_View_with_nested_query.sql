CREATE VIEW UsersWithAnnouncements AS
SELECT "Users".Name,
       (SELECT COUNT(*) FROM announcements WHERE announcements.owner_id = "Users".ID) AS AnnoucementsCount
FROM "Users";