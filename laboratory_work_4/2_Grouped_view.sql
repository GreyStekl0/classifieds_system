CREATE VIEW AnnouncementsPerCategory AS
SELECT categories.title, COUNT(*)
FROM announcements
JOIN categories ON announcements.categories_id = categories.id
GROUP BY categories.title;