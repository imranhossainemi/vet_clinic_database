/* Populate database with sample data. */

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Agumon', date '2020-02-03', 0, true, 10.23);
INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Gabumon', date '2018-11-15', 2, true, 8);
INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Pikachu', date '2021-01-07', 1, false, 15.04);
INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Devimon', date '2017-05-12', 5, true, 11);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Charmander', date '2020-02-08', 0, false, -11);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Plantmon', date '2021-11-15', 2, true, -5.7);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Squirtle', date '1993-04-02', 3, false, -12.13);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Angemon', date '2005-06-12', 1, true, -45);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Boarmon', date '2005-06-07', 7, true, 20.4);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Blossom', date '1998-10-13', 3, true, 17);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
  VALUES ('Ditto', date '2022-05-14' , 4, true, 22);

-- Data entry for owners table

INSERT INTO owners (full_name, owners_age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, owners_age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, owners_age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, owners_age) VALUES ('Melody', 77);
INSERT INTO owners (full_name, owners_age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, owners_age) VALUES ('Jodie Whittaker', 38);

-- Data entry for species table

INSERT INTO species(species_name) VALUES ('Pokemon');
INSERT INTO species(species_name) VALUES ('Digimon');

-- Update animals table
UPDATE animals SET species_id = (SELECT spcies_id FROM species WHERE species_name = 'Digimon') WHERE name like '%mon';
UPDATE animals SET species_id = (SELECT spcies_id FROM species WHERE species_name = 'Pokemon') WHERE name NOT LIKE '%mon';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Sam Smith') WHERE  name = 'Agumon';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE  name = 'Gabumon';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE  name = 'Pikachu';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Bob') WHERE  name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Melody') WHERE  name = 'Charmander' OR name = 'Squirtle' OR name ='Blossom';
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name = 'Dean Winchester') WHERE  name = 'Angemon' OR name='Boarmon';

INSERT INTO vets(vet_name,vet_age,date_of_graduation) VALUES('William', 45, date('2000-04-23'));

INSERT INTO vets(vet_name,vet_age,date_of_graduation) VALUES('Maisy Smith', 26, date('2019-01-17'));

INSERT INTO vets(vet_name,vet_age,date_of_graduation) VALUES('Stephanie Mendez', 64, date('1981-05-04'));

INSERT INTO vets(vet_name,vet_age,date_of_graduation) VALUES('Jack Harkness', 38, date('2008-06-08'));

INSERT INTO specializations(vet_id, species_id) VALUES((SELECT vet_id FROM vets WHERE vet_name = 'William Tatcher'),(SELECT spcies_id FROM species WHERE species_name = 'Pokemon'));

INSERT INTO specializations(vet_id, species_id) VALUES((SELECT vet_id FROM vets WHERE vet_name = 'Stephanie Mendez'),(SELECT spcies_id FROM species WHERE species_name = 'Pokemon'));

INSERT INTO specializations(vet_id, species_id) VALUES((SELECT vet_id FROM vets WHERE vet_name = 'Stephanie Mendez'),(SELECT spcies_id FROM species WHERE species_name = 'Digimon'));

INSERT INTO specializations(vet_id, species_id) VALUES((SELECT vet_id FROM vets WHERE vet_name = 'Jack Harkness'),(SELECT spcies_id FROM species WHERE species_name = 'Digimon'));
