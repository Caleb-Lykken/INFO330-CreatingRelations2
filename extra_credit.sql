 
insert into against_type( type1, type2) VALUES('mascot' , '');

-- add in huskichu
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
INSERT INTO pokemon ("attack", "base_egg_steps", "base_happiness", "base_total", "capture_rate" , "defense", "experience_growth", "height_m", "hp", "name", "percentage_male", "sp_attack", "sp_defense", "speed", "weight_kg", "generation", "is_legendary")
VALUES (200, 10240, 255, 700, 3, 180, 1250000, 1.5, 300, 'Huskichu', NULL, 808, 200, 200, 50, 7, 1);
COMMIT; 
PRAGMA foreign_keys=on;

PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
insert into pokemon_type(typeid, pokedexid) values(167,802);
COMMIT; 
PRAGMA foreign_keys=on;


-- add in cougarite
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
INSERT INTO pokemon ("attack", "base_egg_steps", "base_happiness", "base_total", "capture_rate" , "defense", "experience_growth", "height_m", "hp", "name", "percentage_male", "sp_attack", "sp_defense", "speed", "weight_kg", "generation", "is_legendary")
VALUES (200, 10240, 255, 700, 3, 180, 1250000, 1.5, 300, 'cougarite', NULL, 808, 200, 200, 50, 7, 1);
COMMIT; 
PRAGMA foreign_keys=on;

PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
insert into pokemon_type(typeid, pokedexid) values(167,803);
COMMIT; 
PRAGMA foreign_keys=on;

PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
insert into ability_names(name) values('slow attack');
COMMIT; 
PRAGMA foreign_keys=on;

PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
insert into abilities_ID(abilityID,ability_nameID) values(803,228);
COMMIT; 
PRAGMA foreign_keys=on;

-- create trainer table

CREATE TABLE trainer(
    first_name STRING NVARCHAR(80),
    last_name STRING NVARCHAR(80),
    favorite_pokemon_types INTEGER,
    pokemon_team,
    FOREIGN KEY ([favorite_pokemon_types]) REFERENCES "pokedex_number" ([pokemon])
);
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
INSERT INTO trainer (first_name, last_name, favorite_pokemon_types, pokemon_team)
VALUES ('Caleb', 'Lykken', 311, 'Plusle, Pikachu, Raichu');

INSERT INTO trainer (first_name, last_name, favorite_pokemon_types, pokemon_team)
VALUES ('Ted', 'Neward', 6, 'Charizard, Dragonite, Typhlosion');

INSERT INTO trainer (first_name, last_name, favorite_pokemon_types, pokemon_team)
VALUES ('Karrina', 'TheTa', 1, 'Bulbasaur, Ivysaur, Venusaur');
COMMIT; 
PRAGMA foreign_keys=on;