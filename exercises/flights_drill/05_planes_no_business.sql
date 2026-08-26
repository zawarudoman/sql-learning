/* DRILL 5 — NOT EXISTS
   Модели самолётов, в которых НЕТ мест бизнес-класса.
   Столбцы: airplane_code, модель.
   Схема: airplanes (airplane_code, model),
          seats (airplane_code, fare_conditions). Класс = 'Business'. */


SELECT * FROM segments s JOIN airplanes