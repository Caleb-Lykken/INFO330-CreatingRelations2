-- Caleb Lykken--
-- using recursion to seperate ability values--
CREATE TABLE pokemon_temp AS
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
ALTER TABLE pokemon_temp
RENAME COLUMN abilities TO moves;

ALTER TABLE pokemon_temp
RENAME COLUMN pokedex_number TO dex;



-- trim ablites-- 

UPDATE pokemon_temp SET moves = REPLACE(moves, '[', '');
UPDATE pokemon_temp SET moves = REPLACE(moves, ']', '');
-- using the char(39) charecter witch is the ' charecter --
UPDATE pokemon_temp SET moves = REPLACE(moves, CHAR(39), '');

CREATE TABLE pokemon_1nf AS 
SELECT * FROM pokemon_temp 
JOIN pokemon_import on pokemon_temp.dex = pokemon_import.pokedex_number;

-- drop extra columns with repeating values--
ALTER TABLE pokemon_1nf DROP COLUMN abilities;
ALTER TABLE pokemon_1nf DROP COLUMN pokedex_number;

-- rename columns to corrrect names-- 

ALTER TABLE pokemon_1nf
RENAME COLUMN moves TO abilities;

ALTER TABLE pokemon_1nf
RENAME COLUMN dex TO pokedex_number;
