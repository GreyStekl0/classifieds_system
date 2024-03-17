SELECT categories_id, COUNT(id)
FROM announcements
GROUP BY categories_id;