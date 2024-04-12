INSERT INTO animals (id, title, text, owner_id, categories_id,price)
VALUES (10, 'Продам кота', 'Кот написяль в тапки, продам недорого', 1, 2, 1000);

UPDATE animals
SET id = 11, title = 'Продам попугая', text='Папуг ругается матом, отдам даром',owner_id = 1, categories_id = 2, price = 0
WHERE id = 10;