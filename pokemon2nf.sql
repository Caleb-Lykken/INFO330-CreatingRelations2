
-- change all text data types to correct datatypes -- 
    PRAGMA foreign_keys=off;
    BEGIN TRANSACTION;
    -- define the primary key constraint here
    CREATE TABLE IF NOT EXISTS "pokemon_2nf"(
    "abilities" TEXT,
    "against_bug" FLOAT, 
    "against_dark" FLOAT, 
    "against_dragon" FLOAT,
    "against_electric" FLOAT, 
    "against_fairy" FLOAT, 
    "against_fight" FLOAT,
    "against_fire" FLOAT,
    "against_flying" FLOAT,
    "against_ghost" FLOAT, 
    "against_grass" FLOAT, 
    "against_ground" FLOAT,
    "against_ice" FLOAT,
    "against_normal" FLOAT,
    "against_poison" FLOAT, 
    "against_psychic" FLOAT,
    "against_rock" FLOAT,
    "against_steel" FLOAT,
    "against_water" FLOAT,
        "attack" FLOAT,
    "base_egg_steps" FLOAT,
    "base_happiness" FLOAT,
    "base_total" FLOAT, 
    "capture_rate" FLOAT,
    "classfication" TEXT, 
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
    "type1" FLOAT,
    "type2" FLOAT, 
    "weight_kg" FLOAT, 
    "generation" INTEGER,
    "is_legendary" INTEGER 
    );

    INSERT INTO pokemon_2nf SELECT * FROM pokemon_import;
    COMMIT;
    PRAGMA foreign_keys=on;

-- recursevly clean abilities--
    CREATE TABLE abilities AS
    WITH split(pokedex_number, abilities , nextAbility) AS (
        SELECT pokedex_number, '' AS abilities, abilities|| ',' AS nextAbility
        FROM pokemon_import
        UNION ALL
            SELECT pokedex_number,
            substr(nextAbility, 0, instr(nextAbility, ',')) AS abilities,
            substr(nextAbility, instr(nextAbility, ',')+1) AS nextAbility
        FROM split
        WHERE nextAbility !=''
    )
    SELECT pokedex_number, abilities
    FROM split
    WHERE abilities != ''
    ORDER BY pokedex_number;

-- rename abilities and pokedex_number --
    ALTER TABLE abilities
    RENAME COLUMN abilities TO ability_name;

    ALTER TABLE abilities
    RENAME COLUMN pokedex_number TO id;


-- trim ablites-- 

    UPDATE abilities SET ability_name = REPLACE(ability_name, '[', '');
    UPDATE abilities SET ability_name = REPLACE(ability_name, ']', '');
    -- using the char(39) charecter witch is the ' charecter --
    UPDATE abilities SET ability_name = REPLACE(ability_name, CHAR(39), '');
    UPDATE abilities SET ability_name = REPLACE(ability_name, ' ', '');

-- Alter ablities table adding a foreign key--

    PRAGMA foreign_keys=off;

    BEGIN TRANSACTION;

    ALTER TABLE abilities RENAME TO old_table;

    -- define the primary key constraint here
    CREATE TABLE abilities ( 
    'id' INTEGER,
    'ability_name' INTEGER,
    FOREIGN KEY ([id]) REFERENCES "pokedex_number" ([pokemon_2nf])
    );

    INSERT INTO abilities SELECT * FROM old_table;

    COMMIT;

    PRAGMA foreign_keys=on;
    
    DROP TABLE old_table;
-- drop column "abilites" from pokemon_2nf--
    ALTER TABLE pokemon_2nf DROP COLUMN abilities;
