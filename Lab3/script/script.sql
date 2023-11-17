-- 1.
-- Сделать запрос для получения атрибутов из указанных таблиц, применив фильтры по указанным условиям:
-- Таблицы: Н_ЛЮДИ, Н_ВЕДОМОСТИ.
-- Вывести атрибуты: Н_ЛЮДИ.ОТЧЕСТВО, Н_ВЕДОМОСТИ.ЧЛВК_ИД.
-- Фильтры (AND):
-- a) Н_ЛЮДИ.ИМЯ = Роман.
-- b) Н_ВЕДОМОСТИ.ДАТА < 2022-06-08.
-- c) Н_ВЕДОМОСТИ.ДАТА < 2010-06-18.
-- Вид соединения: INNER JOIN.

SELECT Н_ЛЮДИ.ОТЧЕСТВО, Н_ВЕДОМОСТИ.ЧЛВК_ИД
    FROM Н_ЛЮДИ
    INNER JOIN Н_ВЕДОМОСТИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
    WHERE Н_ЛЮДИ.ИМЯ = 'Роман'
        AND Н_ВЕДОМОСТИ.ДАТА < '2022-06-08'
        AND Н_ВЕДОМОСТИ.ДАТА > '2010-06-18';

-- 2.
-- Сделать запрос для получения атрибутов из указанных таблиц, применив фильтры по указанным условиям:
-- Таблицы: Н_ЛЮДИ, Н_ОБУЧЕНИЯ, Н_УЧЕНИКИ.
-- Вывести атрибуты: Н_ЛЮДИ.ФАМИЛИЯ, Н_ОБУЧЕНИЯ.ЧЛВК_ИД, Н_УЧЕНИКИ.ИД.
-- Фильтры: (AND)
-- a) Н_ЛЮДИ.ИД < 100012.
-- b) Н_ОБУЧЕНИЯ.НЗК < 933232.
-- Вид соединения: INNER JOIN.

SELECT Н_ЛЮДИ.ФАМИЛИЯ, Н_ОБУЧЕНИЯ.ЧЛВК_ИД, Н_УЧЕНИКИ.ИД
    FROM Н_ЛЮДИ
    INNER JOIN Н_УЧЕНИКИ ON Н_ЛЮДИ.ИД = Н_УЧЕНИКИ.ИД
    INNER JOIN Н_ОБУЧЕНИЯ ON Н_УЧЕНИКИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
    WHERE Н_ЛЮДИ.ИД < 100012
        AND Н_ОБУЧЕНИЯ.НЗК < 933232;

-- 3.
-- Вывести число студентов вечерней формы обучения, которые не имеет отчества.
-- Ответ должен содержать только одно число.

SELECT COUNT(*)
    FROM Н_ЛЮДИ
    JOIN Н_ОБУЧЕНИЯ ON Н_ЛЮДИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
    JOIN Н_УЧЕНИКИ ON Н_ОБУЧЕНИЯ.ЧЛВК_ИД = Н_УЧЕНИКИ.ИД 
    JOIN Н_ПЛАНЫ ON  Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
    JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД
    WHERE Н_ЛЮДИ.ОТЧЕСТВО IS NULL	
        AND Н_ФОРМЫ_ОБУЧЕНИЯ.ИД = 2;

-- 4.
-- В таблице Н_ГРУППЫ_ПЛАНОВ найти номера планов, по которым обучается (обучалось) ровно 2 групп на заочной форме обучения.
-- Для реализации использовать подзапрос.

SELECT Н_ПЛАНЫ.НОМЕР
FROM Н_ПЛАНЫ
JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД
WHERE Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'Очно-заочная(вечерняя)'
AND Н_ПЛАНЫ.ИД IN (
    SELECT DISTINCT Н_ГРУППЫ_ПЛАНОВ.ПЛАН_ИД
    FROM Н_ГРУППЫ_ПЛАНОВ
    GROUP BY Н_ГРУППЫ_ПЛАНОВ.ПЛАН_ИД
    HAVING COUNT(Н_ГРУППЫ_ПЛАНОВ.ГРУППА) = 2
)
GROUP BY Н_ПЛАНЫ.НОМЕР;


-- 5.
-- Выведите таблицу со средними оценками студентов группы 4100 (Номер, ФИО, Ср_оценка), у которых средняя оценка не меньше средней оценк(е|и) в группе 1101.

SELECT Н_УЧЕНИКИ.ЧЛВК_ИД,
       Н_ЛЮДИ.ФАМИЛИЯ,
       Н_ЛЮДИ.ИМЯ,
       Н_ЛЮДИ.ОТЧЕСТВО,
       AVG(CAST(Н_ВЕДОМОСТИ.ОЦЕНКА AS DECIMAL)) AS Средняя_оценка
FROM Н_УЧЕНИКИ
        JOIN Н_ОБУЧЕНИЯ ON Н_УЧЕНИКИ.ЧЛВК_ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
        JOIN Н_ЛЮДИ ON Н_ЛЮДИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
        JOIN Н_ВЕДОМОСТИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
WHERE Н_ВЕДОМОСТИ.ОЦЕНКА ~ '^[0-9]+$'
    AND Н_УЧЕНИКИ.ГРУППА = '4100'
GROUP BY (Н_УЧЕНИКИ.ЧЛВК_ИД, Н_ЛЮДИ.ФАМИЛИЯ, Н_ЛЮДИ.ИМЯ, Н_ЛЮДИ.ОТЧЕСТВО) 
HAVING AVG(CAST(Н_ВЕДОМОСТИ.ОЦЕНКА AS DECIMAL)) >= (SELECT AVG(CAST((Н_ВЕДОМОСТИ.ОЦЕНКА) AS DECIMAL))
                                                        FROM Н_ВЕДОМОСТИ
                                                            JOIN Н_ЛЮДИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
                                                            JOIN Н_ОБУЧЕНИЯ ON Н_ЛЮДИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
                                                            JOIN Н_УЧЕНИКИ ON Н_ОБУЧЕНИЯ.ЧЛВК_ИД = Н_УЧЕНИКИ.ЧЛВК_ИД
                                                        WHERE ГРУППА = '1101'
                                                        AND Н_ВЕДОМОСТИ.ОЦЕНКА ~ '^[0-9]+$')
;


-- 6.
-- Получить список студентов, зачисленных до первого сентября 2012 года на первый курс заочной формы обучения (специальность: 230101). В результат включить:
-- номер группы;
-- номер, фамилию, имя и отчество студента;
-- номер и состояние пункта приказа;
-- Для реализации использовать подзапрос с EXISTS.

SELECT ГРУППА,
       ЧЛВК_ИД,
       ФАМИЛИЯ,
       ИМЯ,
       ОТЧЕСТВО,
       СОСТОЯНИЕ,
       Н_УЧЕНИКИ.П_ПРКОК_ИД
FROM Н_УЧЕНИКИ
        JOIN Н_ПЛАНЫ ON Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
        JOIN Н_ЛЮДИ ON Н_УЧЕНИКИ.ЧЛВК_ИД = Н_ЛЮДИ.ИД
        JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД AND Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'Очно-заочная(вечерняя)'
        JOIN Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ ON Н_ПЛАНЫ.НАПС_ИД = Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.ИД
        JOIN Н_НАПР_СПЕЦ ON Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.НС_ИД = Н_НАПР_СПЕЦ.ИД AND Н_НАПР_СПЕЦ.КОД_НАПРСПЕЦ = '230101'
WHERE EXISTS(SELECT ИД
             FROM Н_ФОРМЫ_ОБУЧЕНИЯ
             WHERE НАЧАЛО = '2012-09-01'::TIMESTAMP);

-- 7.
-- Сформировать запрос для получения числа в группе No 3100 отличников.                   

WITH УЧЕНИКИ_3100 AS 
	(
  		SELECT Н_УЧЕНИКИ.ИД, Н_УЧЕНИКИ.ЧЛВК_ИД
    	FROM Н_УЧЕНИКИ
   		WHERE Н_УЧЕНИКИ.ГРУППА = '3100'
	) 
SELECT COUNT(*) FROM 
	(
		SELECT УЧЕНИКИ_3100.ИД FROM УЧЕНИКИ_3100
	 	JOIN Н_ВЕДОМОСТИ USING(ЧЛВК_ИД)
		WHERE ОЦЕНКА = '5' OR ОЦЕНКА = 'зачет'
		GROUP BY УЧЕНИКИ_3100.ИД
	) 
AS ОТЛИЧНИКИ WHERE ОТЛИЧНИКИ.ИД NOT IN 
	(
        SELECT УЧЕНИКИ_3100.ИД FROM УЧЕНИКИ_3100
	 	JOIN Н_ВЕДОМОСТИ USING(ЧЛВК_ИД)
		WHERE ОЦЕНКА != '5' AND ОЦЕНКА != 'зачет'
		GROUP BY УЧЕНИКИ_3100.ИД
	);