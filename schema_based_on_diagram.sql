/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INT,
neutered BIT,
weight_kg DECIMAL,
PRIMARY KEY(id)
);

CREATE TABLE owners(
id INT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(50),
age INT,
PRIMARY KEY(id)
);

CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(50),
PRIMARY KEY(id)
);

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners 
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

-- Create vets table

CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(50),
age INT,
date_of_graduation DATE
);

CREATE TABLE specializations(
species_id INT REFERENCES species(id),
vet_id INT REFERENCES vets(id),
PRIMARY KEY(species_id, vet_id)
);

CREATE TABLE visits(
id INT GENERATED ALWAYS AS IDENTITY,
animal_id INT REFERENCES animals(id),
vet_id INT REFERENCES vets(id),
visit_date DATE,
PRIMARY KEY(id)                     
);