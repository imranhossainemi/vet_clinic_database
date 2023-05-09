/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 date_of_birth date NOT NULL,
 escape_attempts int NOT NULL,
 neutered boolean NOT NULL,
 weight_kg decimal NOT NULL,
 );

ALTER TABLE animals ADD species VARCHAR(100);