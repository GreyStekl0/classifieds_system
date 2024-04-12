INSERT INTO "favorites"
SELECT "Users".id, announcements.id FROM "Users", announcements
WHERE announcements.title like '%собак%'
  AND "Users".id = announcements.owner_id;