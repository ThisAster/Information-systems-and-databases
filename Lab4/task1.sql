-- создание индексов 
CREATE INDEX idx_note ON Н_ОЦЕНКИ using btree(ПРИМЕЧАНИЕ);
CREATE INDEX idx_date_vedomosti ON Н_ВЕДОМОСТИ using btree(ДАТА);

-- Запрос 
EXPLAIN ANALYZE
SELECT Н_ОЦЕНКИ.КОД, Н_ВЕДОМОСТИ.ЧЛВК_ИД
FROM Н_ОЦЕНКИ
INNER JOIN Н_ВЕДОМОСТИ ON Н_ОЦЕНКИ.КОД = Н_ВЕДОМОСТИ.ОЦЕНКА
WHERE Н_ОЦЕНКИ.ПРИМЕЧАНИЕ < 'хорошо'
AND Н_ВЕДОМОСТИ.ДАТА < '1998-01-05'
AND Н_ВЕДОМОСТИ.ДАТА = '2010-06-18';