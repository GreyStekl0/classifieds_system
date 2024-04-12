CREATE OR REPLACE FUNCTION check_animals_insert_update() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.categories_id <> 1 THEN
        RAISE EXCEPTION 'Insert/Update operation rejected. categories_id must be 1.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER animals_insert_trigger
    INSTEAD OF INSERT ON animals
    FOR EACH ROW EXECUTE FUNCTION check_animals_insert_update();

CREATE TRIGGER animals_update_trigger
    INSTEAD OF UPDATE ON animals
    FOR EACH ROW EXECUTE FUNCTION check_animals_insert_update();