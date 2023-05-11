/* Database schema to keep the structure of entire database. */

-- Animals table
CREATE TABLE animals (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 date_of_birth date NOT NULL,
 escape_attempts int NOT NULL,
 neutered boolean NOT NULL,
 weight_kg decimal NOT NULL
 );

ALTER TABLE animals ADD species VARCHAR(100);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (spcies_id) REFERENCES species(spcies_id) ON DELETE CASCADE;

ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owners_id) REFERENCES owners(owners_id) ON DELETE CASCADE;
-- Owners table

CREATE TABLE owners (
  owners_id BIGSERIAL NOT NULL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  owners_age int NOT NULL
);

-- Species Table
CREATE TABLE species(
  spcies_id BIGSERIAL NOT NULL PRIMARY KEY,
  species_name VARCHAR(100)
);

