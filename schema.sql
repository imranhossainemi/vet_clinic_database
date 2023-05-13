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

ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(spcies_id) ON DELETE CASCADE;

ALTER TABLE animals ADD COLUMN owners_id INT, ADD CONSTRAINT fk_owner FOREIGN KEY (owners_id) REFERENCES owners(owners_id) ON DELETE CASCADE;

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

--Vets table
CREATE TABLE vets (
  vet_id BIGSERIAL NOT NULL PRIMARY KEY,
  vet_name VARCHAR(100) NOT NULL,
  vet_age INT NOT NULL,
  date_of_graduation: date NOT NULL
);

CREATE TABLE specializations (
  spe_id BIGSERIAL NOT NULL PRIMARY KEY,
  vet_id BIGSERIAL NOT NULL,
  species_id BIGSERIAL NOT NULL,
  ADD CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(vet_id) ON DELETE CASCADE;
  ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(spcies_id) ON DELETE CASCADE;
);

CREATE TABLE visits (
  visit_id BIGSERIAL NOT NULL PRIMARY KEY,
  vet_id BIGSERIAL NOT NULL,
  animals_id BIGSERIAL NOT NULL,
  date_of_visit date NOT NULL,
  ADD CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(vet_id) ON DELETE CASCADE;
  ADD CONSTRAINT fk_animals_id FOREIGN KEY (animals_id) REFERENCES animals(id) ON DELETE CASCADE;
);


