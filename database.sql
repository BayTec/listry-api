CREATE SCHEMA IF NOT EXISTS listy;

CREATE TABLE IF NOT EXISTS listy.listy (
    id integer PRIMARY KEY,
    name varchar(255)
);

CREATE TABLE IF NOT EXISTS listy.entry (
    id integer PRIMARY KEY,
    name varchar(255),
    amount integer,
    checked boolean
);