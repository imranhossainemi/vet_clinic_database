/* Database schema to keep the structure of entire database. */
CREATE DATABASE clinic;

CREATE TABLE patients(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
PRIMARY KEY(id),
);

CREATE TABLE medical_histories(
id INT GENERATED ALWAYS AS IDENTITY REFERENCES treatments(id),
status VARCHAR,
admitted_at TIMESTAMP,
patient_id int,
PRIMARY KEY(id),
CONSTRAINT fk_patient_id
FOREIGN KEY (patient_id)
REFERENCES patients(id)
ON DELETE CASCADE
);

CREATE TABLE treatments(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY REFERENCES medical_histories(id),
type VARCHAR,
name VARCHAR,
);

ALTER TABLE medical_histories ADD CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES treatments(id);

ALTER TABLE treatments ADD CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES medical_histories(id);

CREATE TABLE invoices(
id INT GENERATED ALWAYS AS IDENTITY,
total_amount DECIMAL,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
medical_history_id INT,
PRIMARY KEY(id),
CONSTRAINT fk_med_history 
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories(id)
ON DELETE CASCADE
);

CREATE TABLE invoice_items(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
unit_price DECIMAL,
quantity INT,
total_price DECIMAL,
invoice_id INT,
treatment_id INT,
CONSTRAINT fk_invoice_id
FOREIGN KEY (invoice_id)
REFERENCES invoices(id)
ON DELETE CASCADE,
CONSTRAINT fk_treatment_id
FOREIGN KEY (treatment_id)
REFERENCES treatments(id)
ON DELETE CASCADE
);
