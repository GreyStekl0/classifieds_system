--1--
CREATE VIEW UsersWithAnnouncements AS
SELECT "Users".Name,
       (SELECT COUNT(*) FROM announcements WHERE announcements.owner_id = "Users".ID) AS AnnoucementsCount
FROM "Users";

CREATE VIEW AnnouncementsPerCategory AS
SELECT categories.title, COUNT(*)
FROM announcements
         JOIN categories ON announcements.categories_id = categories.id
GROUP BY categories.title;

CREATE OR REPLACE VIEW UsersWithAnnouncements_2 AS
SELECT "Users".name, announcements.categories_id, COUNT(announcements.id) AS announcements_count
FROM "Users"
         LEFT JOIN announcements ON "Users".id = announcements.owner_id
GROUP BY "Users".name, announcements.categories_id;

--Категории, обьявления, имя пользователя--

CREATE VIEW animals AS
SELECT *
FROM announcements
WHERE categories_id = 2;

--2--
SELECT * FROM AnnouncementsPerCategory;
SELECT * FROM UsersWithAnnouncements;
SELECT * FROM UsersWithAnnouncements_2;
SELECT * FROM animals;

INSERT INTO animals (id, title, contents, owner_id, categories_id, price)
VALUES (4, 'Продам слона', 'Продам слона недорого', 1, 2, 10);

--не работает--
INSERT INTO animals (id, title, contents, owner_id, categories_id, price)
VALUES (20, 'Продам не слона', 'Продам неслона недорого', 1, 1, 10);
--не работает--

--3--
DROP VIEW animals;
CREATE VIEW animals AS
SELECT *
FROM announcements
WHERE categories_id = 2
WITH CHECK OPTION;

--4--
INSERT INTO animals (id, title, contents, owner_id, categories_id, price)
VALUES (5, 'Продам не слона', 'Продам неслона недорого', 1, 1, 10);

--5--
CREATE OR REPLACE PROCEDURE insert_and_update_announcement(
    p_id integer,
    p_title text,
    p_contents text,
    p_owner_id integer,
    p_categories_id integer,
    p_price numeric
)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO announcements (id, title, contents, owner_id, categories_id, price)
    VALUES (p_id, p_title, p_contents, p_owner_id, p_categories_id, p_price);

    UPDATE announcements
    SET price = p_price * 1.1
    WHERE id = p_id;
END;
$$;

CALL insert_and_update_announcement(6, 'Продам слона', 'Продам слона недорого', 1, 2, 10);

---

CREATE OR REPLACE PROCEDURE select_all_announcements()
    LANGUAGE 'plpgsql'
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT * FROM announcements
        LOOP
            RAISE NOTICE 'Announcement ID: %, Title: %', rec.id, rec.title;
        END LOOP;
END;
$$;

CALL select_all_announcements();

--7--

CREATE OR REPLACE FUNCTION get_announcements_count(p_user_id integer)
    RETURNS TABLE (category_id integer, announcements_count integer) AS $$
BEGIN
    RETURN QUERY
        SELECT announcements.categories_id, CAST(COUNT(*) AS integer)
        FROM announcements
        WHERE announcements.owner_id = p_user_id
        GROUP BY announcements.categories_id;
END;
$$ LANGUAGE plpgsql;

--добавить проверку по категории--

SELECT * FROM get_announcements_count(1);

--8--
CREATE OR REPLACE FUNCTION update_timestamp()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_timestamp_trigger
    BEFORE INSERT OR UPDATE ON announcements
    FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

--

CREATE OR REPLACE FUNCTION log_announcement_deletion()
    RETURNS trigger AS $$
BEGIN
    INSERT INTO announcements_history (announcement_id, title, contents, owner_id, categories_id, price)
    VALUES (OLD.id, OLD.title, OLD.contents, OLD.owner_id, OLD.categories_id, OLD.price);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_deletion_trigger
    BEFORE DELETE ON announcements
    FOR EACH ROW
EXECUTE FUNCTION log_announcement_deletion();

CREATE OR REPLACE FUNCTION update_announcement_on_shopping_insert()
    RETURNS TRIGGER AS $$
DECLARE
    announcement_status BOOLEAN;
BEGIN
    SELECT status INTO announcement_status FROM announcements WHERE id = NEW.announcement_id;
    IF NOT announcement_status THEN
        RAISE EXCEPTION 'Cannot update. The announcement is not active.';
    ELSE
        UPDATE announcements
        SET status = false
        WHERE id = NEW.announcement_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_announcement_trigger
    AFTER INSERT ON shopping
    FOR EACH ROW
EXECUTE FUNCTION update_announcement_on_shopping_insert();

CREATE OR REPLACE FUNCTION prevent_inactive_announcement_update()
    RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status = false THEN
        RAISE EXCEPTION 'Cannot update. The announcement is not active.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_inactive_announcement_update_trigger
    BEFORE UPDATE ON announcements
    FOR EACH ROW
EXECUTE FUNCTION prevent_inactive_announcement_update();

--9--
INSERT INTO announcements (id, title, contents, owner_id, categories_id, price)
VALUES (7, 'Test Insert', 'Testing insert trigger', 1, 2, 20);

INSERT INTO shopping (id, customer_id, vendor_id, announcement_id)
VALUES (2, 3, 1, 5);


UPDATE announcements
SET title = 'Вновь продам Кирилла', contents = 'нашел ещё одного Кирилла на продажу', price = 25
WHERE id = 5;

DELETE FROM announcements WHERE id = 7;

