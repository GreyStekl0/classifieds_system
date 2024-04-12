CREATE OR REPLACE PROCEDURE update_and_insert()
    LANGUAGE plpgsql
AS $$
BEGIN
    -- Обновление записи
    UPDATE announcements
    SET title = 'Обновленный заголовок'
    WHERE id = 1;

    -- Вставка новой записи
    INSERT INTO announcements (id, title, text, owner_id, categories_id, price)
    VALUES (11, 'Новый заголовок', 'Новый текст', 1, 1, 1000);
END;
$$;

CALL update_and_insert();