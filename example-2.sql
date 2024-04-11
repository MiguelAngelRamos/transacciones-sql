CREATE DATABASE online_store;

CREATE USER 'store_admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON online_store.* TO  'store_admin'@'localhost';
FLUSH PRIVILEGES;

use online_store;

CREATE TABLE common_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    spend DECIMAL(10,2)
);

CREATE TABLE premium_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    spend DECIMAL(10,2)
);

INSERT INTO common_users (name, email, spend)
VALUES
('John Doe', 'john.doe@example.com', 50.00),
('Jane Smith', 'jane.smith@example.com', 150.00),
('Emily Johnson', 'emily.johnson@example.com', 290.00),
('Michael Brown', 'michael.brown@example.com', 110.00),
('Jessica Davis', 'jessica.davis@example.com', 500.00);

DELIMITER $$
CREATE PROCEDURE migrate_users_and_rollback_user()
BEGIN
	START TRANSACTION;
    INSERT INTO premium_users (name, email, spend)
    SELECT name, email, spend FROM common_users WHERE user_id IN (1,2);
    DELETE FROM common_users WHERE user_id IN (1,2);
    COMMIT;
    
    START TRANSACTION;
    INSERT INTO premium_users (name, email, spend)
    SELECT name, email, spend FROM common_users WHERE user_id = 3;
    DELETE FROM common_users WHERE user_id = 3;
    ROLLBACK;
END$$
DELIMITER ;
CALL migrate_users_and_rollback_user();
SELECT * FROM common_users;
SELECT * FROM premium_users;

-- Parte 2: Crear tablas.
-- - Crea dos tablas en la base de datos. La primera almacena todos los usuarios sin una participación
-- activa en tu aplicación y la segunda agrupa a los usuarios que son considerados especiales, debido
-- a su alta participación en tu aplicación web.
-- - La primera tabla debe tener 5 usuarios en un comienzo.
-- - La segunda tabla no debe tener usuarios.
-- - Transfiera tres usuarios desde la primera tabla a la segunda.
-- - Anule la transferencia del tercer usuario.

