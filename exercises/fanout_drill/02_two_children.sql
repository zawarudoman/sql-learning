/* =====================================================================
   ФАН-АУТ · Задача 2
   ---------------------------------------------------------------------
   По каждому рейсу выведи:
     • flight_id,
     • плановое время вылета,
     • суммарную выручку по сегментам,
     • число выданных посадочных талонов.

   Только рейсы, где есть хотя бы один сегмент.
   Выручка больше — сверху, первые 50 строк.
   ===================================================================== */

-- ПРОВЕРКА (заполнить ДО агрегатов)
-- строк в segments:                        ______7349504
SELECT COUNT(*)
FROM segments;
-- строк в boarding_passes:                 ______5982418
SELECT COUNT(*)
FROM boarding_passes;
-- строк после всех JOIN:                   ______ 1758830318
-- совпало с ожиданием? да / нет
-- если нет — какой JOIN размножил и почему: ______

WITH price_flight AS (select s.flight_id, SUM(s.price) as sum_flight
                      from segments s
                      where s.fare_conditions IS NOT NULL
                      GROUP BY s.flight_id),
     cnt_boarding_passes AS (SELECT bp.flight_id, COUNT(*) AS cnt_pass FROM boarding_passes bp GROUP BY bp.flight_id)
SELECT f.flight_id, f.scheduled_departure, pf.sum_flight, cbp.cnt_pass
FROM flights f
         JOIN price_flight pf ON pf.flight_id = f.flight_id
         JOIN cnt_boarding_passes cbp ON cbp.flight_id = f.flight_id
ORDER BY pf.sum_flight DESC
LIMIT 50

