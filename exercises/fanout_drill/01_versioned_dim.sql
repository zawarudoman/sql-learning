/* =====================================================================
   ФАН-АУТ · Задача 1
   ---------------------------------------------------------------------
   По каждому городу ВЫЛЕТА посчитай:
     • число рейсов,
     • суммарную выручку по сегментам этих рейсов.

   Больше выручки — сверху.

   ОГРАНИЧЕНИЕ: вьюхой timetable пользоваться НЕЛЬЗЯ.
   Связь "рейс -> аэропорт вылета" строй сам.
   ===================================================================== */

-- ПРОВЕРКА (заполнить ДО агрегатов)
-- строк в segments:                        ______7349504
SELECT COUNT(*) FROM segments;
-- строк после всех JOIN:                   ______7349504
SELECT COUNT(*)
    FROM segments s
         JOIN flights f ON f.flight_id = s.flight_id
         JOIN (SELECT DISTINCT r.route_no, departure_airport FROM routes r) rn  ON rn.route_no = f.route_no
         JOIN airports a ON a.airport_code = rn.departure_airport;
-- совпало? да / нет
-- если нет — какой JOIN размножил и почему: ______

SELECT a.city as city,COUNT(DISTINCT f.flight_id) as cnt_flight, SUM(s.price) as sum_flight
FROM segments s
         JOIN flights f ON f.flight_id = s.flight_id
         JOIN (SELECT DISTINCT r.route_no, departure_airport FROM routes r) rn  ON rn.route_no = f.route_no
         JOIN airports a ON a.airport_code = rn.departure_airport
GROUP BY city
ORDER BY sum_flight DESC;
