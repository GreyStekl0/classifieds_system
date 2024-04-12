CREATE OR REPLACE PROCEDURE update_title(p_id INT, p_title TEXT)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE announcements
    SET title = p_title
    WHERE id = p_id;
END;
$$;

CALL update_title(1, 'Новый заголовок 2');