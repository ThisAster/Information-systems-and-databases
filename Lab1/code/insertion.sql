INSERT INTO Flock_Characteristic(flock_characteristic_name)
VALUES ('голодная');
INSERT INTO Flock_Characteristic(flock_characteristic_name)
VALUES ('удивленная');
INSERT INTO Flock_Characteristic(flock_characteristic_name)
VALUES ('агрессивная');
INSERT INTO Flock_Characteristic(flock_characteristic_name)
VALUES ('усталая');
INSERT INTO Flock_Characteristic(flock_characteristic_name)
VALUES ('радостная');


INSERT INTO Movement_Flock(from_place_name, to_place_name)
VALUES ('озеро', 'тропинка');
INSERT INTO Movement_Flock(from_place_name, to_place_name)
VALUES ('тропинка', 'поле');
INSERT INTO Movement_Flock(from_place_name, to_place_name)
VALUES ('поле', 'вход в пещеру');
INSERT INTO Movement_Flock(from_place_name, to_place_name)
VALUES ('вход в пещеру', 'выход в пещеру');
INSERT INTO Movement_Flock(from_place_name, to_place_name)
VALUES ('выход в пещеру', 'лес');


INSERT INTO Flock_Action(flock_action_name)
VALUES ('удивляется');
INSERT INTO Flock_Action(flock_action_name)
VALUES ('поедает');
INSERT INTO Flock_Action(flock_action_name)
VALUES ('радуется');
INSERT INTO Flock_Action(flock_action_name)
VALUES ('спит');
INSERT INTO Flock_Action(flock_action_name)
VALUES ('атакует');


INSERT INTO Weapon(weapon_name)
VALUES ('палка');
INSERT INTO Weapon(weapon_name)
VALUES ('камень');
INSERT INTO Weapon(weapon_name)
VALUES ('копье');
INSERT INTO Weapon(weapon_name)
VALUES ('факел');


INSERT INTO Leader_Action(leader_action_name)
VALUES ('направляет стаю');
INSERT INTO Leader_Action(leader_action_name)
VALUES ('атакует кабана');
INSERT INTO Leader_Action(leader_action_name)
VALUES ('следит за безопасностью стаи');


INSERT INTO Leader(leader_name, leader_action_id, weapon_id)
VALUES ('Лопоухий', 1, NULL);
INSERT INTO Leader(leader_name, leader_action_id, weapon_id)
VALUES ('Длинноухий', 2, 2);
INSERT INTO Leader(leader_name, leader_action_id, weapon_id)
VALUES ('Наблюдающий', 3, NULL);
INSERT INTO Leader(leader_name, leader_action_id, weapon_id)
VALUES ('Стражник', 3, 4);


INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES ('первый сородич', 3, 2);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES ('второй сородич', 1, 1);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES ('третий сородич', 3, 2);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 2);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 3);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 1);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 2);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 2);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 4);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 4);
INSERT INTO Tribesman(tribesman_name, weapon_id, leader_id)
VALUES (NULL, NULL, 4);


INSERT INTO Flock(flock_name, leader_id)
VALUES('первая стая', 2);
INSERT INTO Flock(flock_name, leader_id)
VALUES('вторая стая', 3);
INSERT INTO Flock(flock_name, leader_id)
VALUES('третья стая', 4);
INSERT INTO Flock(flock_name, leader_id)
VALUES('четвертая стая', 1);


INSERT INTO Flock_to_Characteristic
SELECT 1, 3
WHERE
    NOT EXISTS (
        SELECT flock_id, f_characteristic_id FROM Flock_to_Characteristic WHERE flock_id = 1 and f_characteristic_id = 3
    );
INSERT INTO Flock_to_Characteristic
SELECT 2, 4
WHERE
    NOT EXISTS (
        SELECT flock_id, f_characteristic_id FROM Flock_to_Characteristic WHERE flock_id = 2 and f_characteristic_id = 4
    );
INSERT INTO Flock_to_Characteristic
SELECT 3, 1
WHERE
    NOT EXISTS (
        SELECT flock_id, f_characteristic_id FROM Flock_to_Characteristic WHERE flock_id = 3 and f_characteristic_id = 1
    );
INSERT INTO Flock_to_Characteristic
SELECT 4, 5
WHERE
    NOT EXISTS (
        SELECT flock_id, f_characteristic_id FROM Flock_to_Characteristic WHERE flock_id = 4 and f_characteristic_id = 5
    );


-- Запрос, который попросили сделать на сдаче лабы (вывести список стай, в которых сородич имеет оружие факел)
-- SELECT * FROM Flock INNER JOIN Leader ON flock.flock_id = leader.leader_id INNER join Tribesman ON leader.leader_id = tribesman.tribesman_id WHERE tribesman.weapon_id = 3;
