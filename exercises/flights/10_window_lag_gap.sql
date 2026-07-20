/* =====================================================================
   Задание 10. Интервал между рейсами маршрута
   Тема: lag() — заглянуть в предыдущую строку
   ---------------------------------------------------------------------
   ЗАДАЧА:
   Для каждого рейса покажи, сколько времени прошло с ПРЕДЫДУЩЕГО рейса
   того же маршрута.
   Столбцы: route_no, flight_id, scheduled_departure,
            вылет предыдущего рейса, разница между ними.
   Ограничь 50 строками.

   Помни:
     lag(x)  = значение ПРЕДЫДУЩЕЙ строки (смотрит назад)
     lead(x) = значение СЛЕДУЮЩЕЙ строки (смотрит вперёд)
   Пиши "предыдущее" как lag + ORDER BY по возрастанию — не разворачивай
   порядок без нужды.

   У самого первого рейса маршрута предыдущего нет → там будет пусто (NULL).
   ===================================================================== */

SELECT t.route_no,
       t.flight_id,
       t.scheduled_departure,
       lag(t.scheduled_departure) OVER (PARTITION BY route_no ORDER BY t.scheduled_departure) as prev_departure,
       t.scheduled_departure - lag(t.scheduled_departure) OVER (PARTITION BY route_no ORDER BY t.scheduled_departure) as diff
FROM timetable t
ORDER BY t.route_no
LIMIT 50
