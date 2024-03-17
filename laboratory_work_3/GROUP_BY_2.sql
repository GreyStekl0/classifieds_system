SELECT "Users".id, announcements.categories_id, COUNT("Users".id)
FROM "Users" JOIN "announcements"
    ON "Users".id = announcements.owner_id
GROUP BY "Users".id, announcements.categories_id;