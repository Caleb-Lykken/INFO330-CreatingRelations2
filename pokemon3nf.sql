ALTER TABLE pokemon_2nf RENAME TO pokemon;
ALTER TABLE pokemon RENAME COLUMN classfication to classification;
-- Creating tables for abilities
    -- create table of distinct abilities with a auto incrementing id --
        CREATE TABLE ability_names(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            'name' STRING
        );

        INSERT INTO ability_names (name)
        SELECT DISTINCT ability_name
        FROM abilities;

    -- create table that relates the pokedex number with the ability -- 
        PRAGMA foreign_keys=off;
        BEGIN TRANSACTION;
        CREATE TABLE abilities_ID(
            abilityID INTEGER,
            ability_nameID INTEGER,
            FOREIGN KEY ([abilityID]) REFERENCES "pokedex_number" ([pokemon]),
            FOREIGN KEY ([ability_nameID]) REFERENCES "id" ([ability_names])
        );
        INSERT INTO abilities_ID SELECT * FROM abilities;
        COMMIT;
    PRAGMA foreign_keys=on;
    -- make abilites equal the id of the ability of the ability column -- 
        PRAGMA foreign_keys=off;
        BEGIN TRANSACTION;
        UPDATE abilities_ID
        SET ability_nameID = ability_names.id
        FROM ability_names
        WHERE abilities_ID.ability_nameID = ability_names.name;
        COMMIT;
        PRAGMA foreign_keys=on;

    -- drop the table abilities --
        DROP TABLE abilities;

--Creating tables for types and effectivness-- 

    -- make against type table
    CREATE TABLE against_type(
    id INTEGER PRIMARY KEY AUTOINCREMENT ,
    type1 TEXT,
    type2 TEXT,
    against_bug FLOAT,
    against_dark FLOAT,
    against_dragon FLOAT,
    against_electric FLOAT,
    against_fairy FLOAT,
    against_fight FLOAT,
    against_fire FLOAT,
    against_flying FLOAT,
    against_ghost FLOAT,
    against_grass FLOAT,
    against_ground FLOAT,
    against_ice FLOAT,
    against_normal FLOAT,
    against_poison FLOAT,
    against_psychic FLOAT,
    against_rock FLOAT,
    against_steel FLOAT,
    against_water FLOAT
    );
    INSERT INTO against_type( 

    type1,
    type2,
    against_bug ,
    against_dark ,
    against_dragon ,
    against_electric,
    against_fairy,
    against_fight,
    against_fire,
    against_flying,
    against_ghost,
    against_grass,
    against_ground,
    against_ice,
    against_normal,
    against_poison,
    against_psychic,
    against_rock,
    against_steel ,
    against_water ) SELECT DISTINCT
    type1,
    type2,
    against_bug ,
    against_dark ,
    against_dragon ,
    against_electric,
    against_fairy,
    against_fight,
    against_fire,
    against_flying,
    against_ghost,
    against_grass,
    against_ground,
    against_ice,
    against_normal,
    against_poison,
    against_psychic,
    against_rock,
    against_steel ,
    against_water 
    FROM pokemon ORDER BY pokedex_number; 
    -- create table that relates the pokedex number with the ability -- 
            PRAGMA foreign_keys=off;
            BEGIN TRANSACTION;
            CREATE TABLE pokemon_type(
                typeid INTEGER,
                pokedexid INTEGER,
                type1 TEXT,
                type2 TEXT,
                FOREIGN KEY ([pokedexid]) REFERENCES "pokedex_number" ([pokemon]),
                FOREIGN KEY ([typeid]) REFERENCES "id" ([against_type])
            );
            INSERT INTO pokemon_type SELECT against_fire, pokedex_number , type1, type2 FROM pokemon;
            COMMIT; 
            PRAGMA foreign_keys=on;
    -- make poekdexid equal the id of the pokemon with the attributed type -- 
            PRAGMA foreign_keys=off;
            BEGIN TRANSACTION;
            UPDATE pokemon_type
            SET typeid = against_type.id
            FROM against_type
            WHERE pokemon_type.type1 = against_type.type1 and pokemon_type.type2 = against_type.type2;
            COMMIT;
            PRAGMA foreign_keys=on;
        
        -- drop type1 and type2 -- 
        ALTER TABLE pokemon_type DROP COLUMN type1;
        ALTER TABLE pokemon_type DROP COLUMN type2;

-- new line -- 
CREATE TABLE classification(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT
);
INSERT INTO classification(description) SELECT DISTINCT classification FROM pokemon;


ALTER TABLE pokemon DROP COLUMN against_bug;
ALTER TABLE pokemon DROP COLUMN against_dark;
ALTER TABLE pokemon DROP COLUMN against_dragon;
ALTER TABLE pokemon DROP COLUMN against_electric;
ALTER TABLE pokemon DROP COLUMN against_fairy;
ALTER TABLE pokemon DROP COLUMN against_fight;
ALTER TABLE pokemon DROP COLUMN against_fire;
ALTER TABLE pokemon DROP COLUMN against_flying;
ALTER TABLE pokemon DROP COLUMN against_ghost;
ALTER TABLE pokemon DROP COLUMN against_grass;
ALTER TABLE pokemon DROP COLUMN against_ground;
ALTER TABLE pokemon DROP COLUMN against_ice;
ALTER TABLE pokemon DROP COLUMN against_normal;
ALTER TABLE pokemon DROP COLUMN against_poison;
ALTER TABLE pokemon DROP COLUMN against_psychic;
ALTER TABLE pokemon DROP COLUMN against_rock;
ALTER TABLE pokemon DROP COLUMN against_steel;
ALTER TABLE pokemon DROP COLUMN against_water;
ALTER TABLE pokemon DROP COLUMN type1;
ALTER TABLE pokemon DROP COLUMN type2;

ALTER TABLE pokemon RENAME TO old_pokemon;
 PRAGMA foreign_keys=off;
 BEGIN TRANSACTION;
 CREATE TABLE "pokemon"(
    "attack" FLOAT,
    "base_egg_steps" FLOAT,
    "base_happiness" FLOAT,
    "base_total" FLOAT,
    "capture_rate" FLOAT,
    "classificationId" TEXT,
    "defense" FLOAT,
    "experience_growth" FLOAT,
    "height_m" FLOAT,
    "hp" FLOAT,
    "name" TEXT,
    "percentage_male" FLOAT,
    "pokedex_number" INTEGER PRIMARY KEY,
    "sp_attack" FLOAT,
    "sp_defense" FLOAT,
    "speed" FLOAT,
    "weight_kg" FLOAT,
    "generation" INTEGER,
    "is_legendary" INTEGER,
    FOREIGN KEY ([classificationId]) REFERENCES "id" ([classification])
    );
    INSERT INTO pokemon SELECT * FROM  old_pokemon;
    COMMIT; 
    PRAGMA foreign_keys=on;
DROP TABLE old_pokemon;

PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
UPDATE pokemon
SET classificationId = classification.id
FROM classification
WHERE classificationId = classification.description;
COMMIT; 
PRAGMA foreign_keys=on;

DROP TABLE pokemon_import;