/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id BIGINT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INT,
neutered boolean,
weight_kg DECIMAL,
species_id INT,
owner_id INT,
PRIMARY KEY(id),
CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(spcies_id)
ON DELETE CASCADE,
CONSTRAINT fk_owners 
FOREIGN KEY (owner_id)
REFERENCES owners(owners_id)
ON DELETE CASCADE
);

CREATE TABLE owners(
owners_id BIGINT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(50),
owners_age INT,
PRIMARY KEY(owners_id)
);

CREATE TABLE species(
spcies_id INT GENERATED ALWAYS AS IDENTITY,
species_name VARCHAR(50),
PRIMARY KEY(spcies_id)
);

-- Create vets table

CREATE TABLE vets(
vet_id INT GENERATED ALWAYS AS IDENTITY,
vet_name VARCHAR(50),
vet_age INT,
date_of_graduation DATE
);

CREATE TABLE specializations(
spe_id BIGINT GENERATED ALWAYS AS IDENTITY,
species_id BIGINT REFERENCES species(spcies_id),
vet_id BIGINT REFERENCES vets(vet_id),
PRIMARY KEY(spe_id)
);

CREATE TABLE visits(
visit_id BIGINT GENERATED ALWAYS AS IDENTITY,
animals_id BIGINT REFERENCES animals(id),
vet_id BIGINT REFERENCES vets(id),
date_of_visit DATE,
PRIMARY KEY(visit_id)                     
);