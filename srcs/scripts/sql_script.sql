-- --------------------------------------------------------

--
-- Table for WordPress `wordpress`
--

CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'ft_admin'@'localhost' IDENTIFIED BY 'ft_admin';
GRANT ALL PRIVILEGES ON *.* TO 'ft_admin'@'localhost';
FLUSH PRIVILEGES;
