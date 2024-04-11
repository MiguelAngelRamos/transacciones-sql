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

START TRANSACTION;
-- Seleccionar a los usuarios que deseamos transferir o promover para enviarlos a la tabla de premium_users
INSERT INTO premium_users (name, email, spend) SELECT name, email, spend FROM common_users WHERE spend > 140;
-- Eliminar
DELETE FROM common_users WHERE spend > 140;
COMMIT; -- ROLLBACK INDICANDO QUE SE CANCELA TODO POR EL TERCER USUARIO

SELECT * FROM common_users;
SELECT * FROM premium_users;





