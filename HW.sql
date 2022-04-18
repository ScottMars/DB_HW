CREATE TABLE stock (
  id serial primary key,
  name VARCHAR(255) DEFAULT '',
  address VARCHAR(255) DEFAULT '',
  capacity integer DEFAULT 0,
  created TIMESTAMP DEFAULT NOW(),
  updated TIMESTAMP DEFAULT NOW()
);

CREATE TABLE type (id serial primary key, name VARCHAR(255) DEFAULT '');

CREATE TABLE brand (
  id serial primary key,
  name VARCHAR(255) DEFAULT ''
);

CREATE TABLE good (
  id serial primary key,
  name VARCHAR(255),
  amount integer,
  price integer,
  brand_id integer REFERENCES brand (id),
  type_id integer REFERENCES type(id),
  stock_id integer REFERENCES stock (id),
  created TIMESTAMP DEFAULT NOW(),
  updated TIMESTAMP DEFAULT NOW(),
  avaliable BOOLEAN
);

CREATE TABLE store (
  id serial primary key,
  name VARCHAR(255) DEFAULT '',
  address VARCHAR(255) DEFAULT '',
  created TIMESTAMP DEFAULT NOW(),
  updated TIMESTAMP DEFAULT NOW()
);

CREATE TABLE goods_to_store (
  id serial,
  store_id integer REFERENCES store(id) ON UPDATE CASCADE ON DELETE CASCADE,
  good_id integer REFERENCES good(id) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT goods_to_store_pk PRIMARY KEY (store_id, good_id)
);


-- Insert

INSERT INTO store VALUES (1,'Auchan', 'Pobedy str.', '2021-10-22 10:23:54', '2021-11-13 11:53:54');
INSERT INTO store (name, address, created, updated) VALUES ('Pyaterochka', 'Yaroslavskaya str', '2021-10-19 10:23:54', '2021-11-19 11:53:54');
SELECT * FROM store;

INSERT INTO stock (name, address, created, updated) 
SELECT name, address, created, updated FROM store WHERE ID=1;

-- Delete
DELETE FROM stock;
DELETE FROM store WHERE name='Auchan'

-- UPDATE
UPDATE store SET name='Okay', address='Dmitrovsky prosp' WHERE id = 1;

-- SELECT

SELECT * FROM store;
SELECT name FROM store;
SELECT * FROM store WHERE id = 1;

-- SELECT ORDER BY + TOP (LIMIT)
SELECT * FROM store ORDER BY id ASC LIMIT 1;
SELECT * FROM store ORDER BY id DESC;
SELECT * FROM store ORDER BY name, address LIMIT 1;
SELECT * FROM store ORDER BY name ASC;

INSERT INTO stock (name, address, capacity, created, updated) VALUES ('Auchan', 'Pobedy str.', 200, '2021-10-19 10:23:54', '2021-11-19 11:53:54');
INSERT INTO stock (name, address, capacity, created, updated) VALUES ('Auchan', 'Vozdvizenskaya str.', 400, '2021-10-19 10:23:54', '2021-11-19 11:53:54');
INSERT INTO stock (name, address, created, updated) VALUES ('Pyaterochka', 'Varshavskaya str', '2021-10-22 10:23:54', '2021-11-13 11:53:54');
SELECT * FROM stock;

-- Функции агрегации
SELECT MAX(capacity) FROM stock;
SELECT MIN(capacity) FROM stock;
SELECT COUNT(name) FROM stock GROUP BY id;

---SELECT GROUP BY + HAVING

-- Получение адрессов складов с объемом более 100 единиц отсортированными по вместимости
SELECT address FROM stock GROUP BY capacity, address HAVING capacity > 100 ;

-- Получение адрессов складов с объемом менее 100 единиц отсортированными по вместимости
SELECT address FROM stock GROUP BY capacity, address HAVING capacity < 100 ;

-- Получение наименования складов с объемом более 100 единиц отсортированными по вместимости
SELECT name FROM stock GROUP BY capacity, name HAVING capacity > 100 ;