CREATE TABLE IF NOT EXISTS Flock_Characteristic (
    f_characteristic_id SERIAL PRIMARY KEY NOT NULL,
    flock_characteristic_name VARCHAR(255) NOT NULL check ( length(flock_characteristic_name) > 0 )
);

CREATE TABLE IF NOT EXISTS Movement_Flock (
    movement_flock_id SERIAL PRIMARY KEY NOT NULL,
    from_place_name VARCHAR(100) NOT NULL check ( length(from_place_name) > 0 ), 
    to_place_name VARCHAR(100) NOT NULL check ( length(to_place_name) > 0 )
);

CREATE TABLE IF NOT EXISTS Flock_Action (
    flock_action_id SERIAL PRIMARY KEY NOT NULL,
    flock_action_name VARCHAR(255) NOT NULL check ( length(flock_action_name) > 0 )
);

CREATE TABLE IF NOT EXISTS Weapon (
    weapon_id SERIAL PRIMARY KEY NOT NULL,
    weapon_name VARCHAR(100) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Leader_Action (
    leader_action_id SERIAL PRIMARY KEY NOT NULL,
    leader_action_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Leader (
    leader_id SERIAL PRIMARY KEY NOT NULL,
    leader_name VARCHAR(100) NOT NULL check ( length(leader_name) > 0 ),
    leader_action_id INT REFERENCES leader_action (leader_action_id),
    weapon_id INT REFERENCES weapon (weapon_id)
);

CREATE TABLE IF NOT EXISTS Tribesman (
    tribesman_id SERIAL PRIMARY KEY,
    tribesman_name VARCHAR(100),
    weapon_id INT REFERENCES weapon (weapon_id),
    leader_id INT REFERENCES leader (leader_id) NOT NULL
);

CREATE TABLE IF NOT EXISTS Flock (
    flock_id SERIAL PRIMARY KEY NOT NULL,
    flock_name VARCHAR(100) NOT NULL check ( length(flock_name) > 0 ),
    leader_id INT REFERENCES leader (leader_id) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Flock_to_Characteristic (
    flock_id INT REFERENCES flock(flock_id) NOT NULL,
    f_characteristic_id INT REFERENCES flock_characteristic (f_characteristic_id) NOT NULL
);




