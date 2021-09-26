/* TODO: table history */

SET client_encoding = 'UTF8';

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS spots;
DROP TABLE IF EXISTS spots_users;

DROP TYPE IF EXISTS user_role;
DROP TYPE IF EXISTS order_status;

CREATE TYPE user_role AS ENUM ('admin', 'client');
CREATE TYPE order_status AS ENUM ('delivered', 'canceled', 'opened', 'accepted');

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  role user_role NOT NULL
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price_usd NUMERIC (15, 6) NOT NULL,
  description TEXT,
  category_id INT NOT NULL,
  CONSTRAINT fk_category FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  status order_status NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  delivered_at TIMESTAMPTZ,
  cacelled_at TIMESTAMPTZ,
  opened_at TIMESTAMPTZ,
  accepted_at TIMESTAMPTZ,
  user_id INT NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)  
);

CREATE TABLE orders_items (
  order_id INT,
  item_id INT,
  PRIMARY KEY (order_id, item_id),
  CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(id),
  CONSTRAINT fk_item FOREIGN KEY(item_id) REFERENCES items(id)
);

CREATE TABLE spots (
  id SERIAL PRIMARY KEY,
  label TEXT NOT NULL,
  is_free BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE spots_users (
  spot_id INT,
  user_id INT,
  PRIMARY KEY (spot_id, user_id),
  CONSTRAINT fk_spot FOREIGN KEY(spot_id) REFERENCES spots(id),
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)
);

