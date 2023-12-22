-- Создание индексов
CREATE INDEX idx_people_patronymic ON Н_ЛЮДИ using btree("ОТЧЕСТВО");
CREATE INDEX idx_vedomosti_chlvk_id ON Н_ВЕДОМОСТИ using btree("ЧЛВК_ИД");

-- Запрос 
EXPLAIN ANALYZE
SELECT Н_ЛЮДИ.ФАМИЛИЯ, Н_ВЕДОМОСТИ.ЧЛВК_ИД, Н_СЕССИЯ.УЧГОД
FROM Н_ЛЮДИ
LEFT JOIN Н_ВЕДОМОСТИ ON Н_ВЕДОМОСТИ.ЧЛВК_ИД = Н_ЛЮДИ.ИД
LEFT JOIN Н_СЕССИЯ ON Н_СЕССИЯ.ЧЛВК_ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ОТЧЕСТВО > 'Сергеевич'
  AND Н_ВЕДОМОСТИ.ЧЛВК_ИД > 142390;
