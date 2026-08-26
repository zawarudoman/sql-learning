/* =====================================================================
   ЭКЗАМЕН 1 · Задача 4 (10 баллов)
   ---------------------------------------------------------------------
   Отчёт по маршрутам (route_no). Для каждого маршрута выведи:
     • номер маршрута,
     • сколько рейсов запланировано ВСЕГО,
     • сколько из них фактически вылетело,
     • среднюю задержку вылета в МИНУТАХ (округли до 1 знака).

   Бери только маршруты, где запланировано не меньше 50 рейсов.
   Самые опаздывающие — сверху.

   ⚠️ Числа в одной строке должны относиться к согласованным множествам —
      следи, по каким именно рейсам считается каждый столбец.
   ===================================================================== */

SELECT f.route_no as number_route,
       COUNT(*)   as cnt_all_flight_route,
       (SELECT COUNT(*) FROM flights f1 WHERE f1.status = 'Arrived' AND f1.route_no = f.route_no GROUP BY f1.route_no, f.route_no) AS cnt_arrived_route,
       ROUND(AVG(EXTRACT(EPOCH FROM (f.actual_departure - f.scheduled_departure)) / 60),2) AS minutes_diff
FROM routes r
         JOIN flights f ON f.route_no = r.route_no
GROUP BY f.route_no
HAVING (SELECT COUNT(*) FROM flights f1 WHERE f1.status = 'Arrived' AND f1.route_no = f.route_no GROUP BY f1.route_no, f.route_no) > 50
ORDER BY f.route_no;

