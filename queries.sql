/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon".*/
SELECT * from animals WHERE name like '%mon';

/* List the name of all animals born between 2016 and 2019*/
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01'  AND  '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts*/
SELECT name from animals WHERE escape_attempts < 3  AND neutered = true;

/* List the date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT date_of_birth from animals WHERE name = 'Agumon'  or  name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg"*/
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

/* Find all animals that are neutered"*/
SELECT * from animals WHERE neutered = true;

/* Find all animals not named Gabumon"*/
SELECT * from animals WHERE name != 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.*/

BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;
/*
Inside a transaction:

    Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    Verify that changes were made.
    Commit the transaction.
    Verify that changes persist after commit
*/
BEGIN;

UPDATE animals SET species = 'digimon' WHERE name like '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

/*
Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
*/
BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/*
Inside a transaction:

    Delete all animals born after Jan 1st, 2022.
*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

-- Create a savepoint for the transaction.
SAVEPOINT del_date;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT del_date;
SELECT * FROM animals;

--Update all animals' weights that are negative to be their weight multiplied by -1. Commit transaction
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(id) FROM animals;

--How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '1999-12-31';

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts) FROM animals WHERE neutered = false OR true;

--What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;

--What animals belong to Melody Pond?
SELECT name FROM animals INNER JOIN owners ON animals.owners_id = owners.owners_id WHERE owners.full_name = 'Melody';

--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals INNER JOIN species ON animals.species_id = species.spcies_id WHERE species.species_name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM animals RIGHT JOIN owners ON animals.owners_id = owners.owners_id;

--How many animals are there per species?
SELECT species.species_name as species_name, COUNT(*) as num_animals
FROM animals
JOIN species ON animals.species_id = species.spcies_id
GROUP BY species.species_name;

--List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals INNER JOIN owners ON animals.owners_id = owners.owners_id INNER JOIN species ON animals.species_id = species.spcies_id  WHERE owners.full_name = 'Jennifer Orwell' AND species.species_name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals INNER JOIN owners ON animals.owners_id = owners.owners_id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

--Who owns the most animals?
SELECT owners.full_name,COUNT(animals.id) AS num_animals FROM owners INNER JOIN animals ON owners.owners_id = animals.owners_id GROUP BY owners.owners_id ORDER BY num_animals DESC LIMIT 1;

/* Who was the last animal seen by William Tatcher? */
SELECT
  vets.vet_name AS VET,
  animals.name AS last_visited
FROM
  visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animals_id = animals.id
WHERE
  vets.vet_name = 'William Tatcher'
ORDER BY
  date_of_visit DESC
LIMIT
  1;

  /*How many different animals did Stephanie Mendez see?*/
SELECT
  vets.vet_name AS VET,
  count(DISTINCT animals.species_id) AS NUMBER_OF_different_animals
FROM
  visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
WHERE
  vets.vet_name = 'Stephanie Mendez'
GROUP BY
  vets.vet_name;

/*List all vets and their specialties, including vets with no specialties.*/
SELECT
  vets.vet_name AS vet,
  COALESCE(species.species_name, 'No specialty') AS specializations
FROM
  vets
  LEFT JOIN specializations ON vet_id = vets.vet_id
  LEFT JOIN species ON species_id = species.spcies_id
ORDER BY
  vets.vet_name;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT
  visits.date_of_visit AS visited_date,
  animals.name AS visitor
FROM
  visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vet_id = vets.vet_id
WHERE
  vets.vet_name = 'Stephanie Mendez'
  AND date_of_visit between DATE '2020-04-01'
  AND '2020-08-30'
ORDER BY
  date_of_visit DESC;

/* What animal has the most visits to vets? */
SELECT
  animals.name AS animal,
  count(*) AS most_VISITS
FROM
  visits
  JOIN animals ON visits.animals_id = animals.id
GROUP BY
  animals.name
ORDER BY
  most_VISITS DESC
LIMIT
  1;

/*Who was Maisy Smith's first visit?*/
SELECT
  animals.name AS visited,
  vets.vet_name AS vet
FROM
  visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vet_id = vets.vet_id
WHERE
  vets.vet_name = 'Maisy Smith'
ORDER BY
  date_of_visit ASC
LIMIT
  1;

/* Details for most recent visit: animal information, vet information, and date of visit */
SELECT
  vets.*,
  animals.*,
  visits.date_of_visit
from
  visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vet_id = vets.vet_id
ORDER BY
  date_of_visit DESC
LIMIT
  1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT
  count(*) / 3 AS counter
FROM
  visits
  LEFT JOIN animals ON animals.id = visits.animals_id
  LEFT JOIN vets ON vets.vet_id = visits.vet_id
WHERE
  animals.species_id NOT IN (
    SELECT
      species_id
    FROM
      specializations
    WHERE
      vet_id = vets.vet_id
  );

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT
  species.species_name,
  count(*) / 3 AS counter
FROM
  visits
  JOIN animals ON animals.id = visits.animals_id
  JOIN species ON animals.species_id = species.spcies_id
  JOIN vets ON vets.vet_id = visits.vet_id
WHERE
  vets.vet_name = 'Maisy Smith'
GROUP BY
  species.species_name;