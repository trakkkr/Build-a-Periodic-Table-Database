# freeCodeCamp/Build-a-Periodic-Table-Database

CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
);

ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;

ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE elements ADD UNIQUE(name);

ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;

ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);

CREATE TABLE types(
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(20) NOT NULL
);

INSERT INTO types(type) VALUES('nonmetal'), ('metal'), ('metalloid');

ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);
UPDATE properties SET type_id=1 WHERE type='nonmetal';
UPDATE properties SET type_id=2 WHERE type='metal';
UPDATE properties SET type_id=3 WHERE type='metalloid';
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;

UPDATE elements SET symbol = 'He' WHERE symbol = 'he';
UPDATE elements SET symbol = 'Li' WHERE symbol = 'li';
UPDATE elements SET symbol = 'Mt' WHERE symbol = 'mT';

-- ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL;
-- This didn't work well, so I had to redo it manually.

INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 'nonmetal', 18.998, -220, -188.1, 1);

INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 1);

DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;

ALTER TABLE properties DROP COLUMN type;
