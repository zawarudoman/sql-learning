/* =====================================================================
   ЭКЗАМЕН 1 · Задача 3 (10 баллов)
   ---------------------------------------------------------------------
   Как распределены рейсы по статусам?

   Выведи по каждому статусу:
     • статус,
     • число рейсов,
     • долю этого статуса от ОБЩЕГО числа рейсов, в процентах,
       округлённую до 2 знаков.

   Самые частые статусы — сверху.
   Проверь себя: сумма всех долей должна дать 100.
   ===================================================================== */

WITH flight_status as (SELECT COUNT(*) as cnt_flight_status, f.status
                       FROM flights f
                       GROUP BY f.status),
     cnt_flights as (SELECT COUNT(*) as sum_all_flight FROM flights)
SELECT status, sum_all_flight, ROUND(cnt_flight_status / sum_all_flight::numeric * 100, 2)
FROM flight_status,
     cnt_flights
