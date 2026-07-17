/* =====================================================================
   Задание 6. Средняя задержка по городам
   Тема: CTE + агрегаты + JOIN (собираем всё вместе)
   ---------------------------------------------------------------------
   ЗАДАЧА:
   Посчитай среднюю задержку вылета ПО КАЖДОМУ городу вылета.
   Столбцы: город, число рейсов, средняя задержка (в минутах).
   Города с самой большой средней задержкой — сверху.
   Возьми только города, где было хотя бы 100 вылетевших рейсов.

   Подсказки:
   • задержку в МИНУТАХ можно получить так:
       EXTRACT(EPOCH FROM (actual_departure - scheduled_departure)) / 60
     (EPOCH даёт разницу в секундах, делим на 60)
   • "хотя бы 100 рейсов" — это условие на группу → HAVING
   • город вылета: routes.departure_airport → airports.city

   Структура: WITH считает задержки по рейсам → снаружи группируем по городу.
   ===================================================================== */

--- вариант без CTE
SELECT a.city,
       AVG(EXTRACT(EPOCH FROM (t.actual_departure - t.scheduled_departure)) / 60) as delay_min,
       COUNT(flight_id)                                                           as count_flight
FROM timetable t
         JOIN airports a ON a.airport_code = t.departure_airport
WHERE t.flight_id IS NOT NULL
GROUP BY a.city
HAVING COUNT(flight_id) > 100
ORDER BY delay_min DESC;


WITH delay as (SELECT t.departure_airport                                                   as airport,
                      EXTRACT(EPOCH FROM (t.actual_departure - t.scheduled_departure)) / 60 as delay_min,
                      t.flight_id                                                           as flight
               FROM timetable t
               WHERE t.actual_departure IS NOT NULL)
SELECT a.city, AVG(d.delay_min) as avg_delay_min, COUNT(d.flight) as count_flight
FROM delay d
         JOIN airports a ON a.airport_code = d.airport
GROUP BY a.city
HAVING COUNT(flight) > 100
ORDER BY avg_delay_min DESC;

