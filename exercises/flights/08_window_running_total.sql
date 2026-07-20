/* =====================================================================
   Задание 8. Нарастающий итог рейсов по дням
   Тема: SUM() OVER (ORDER BY ...) — running total
   ---------------------------------------------------------------------
   ЗАДАЧА:
   Посчитай, сколько рейсов вылетало каждый день, и рядом —
   НАРАСТАЮЩИЙ итог (сколько всего рейсов накопилось с начала периода).
   Столбцы: дата, рейсов за день, нарастающий итог. По возрастанию даты.

   Подсказки:
   • "дата" из timestamp: scheduled_departure::date
   • сначала посчитай рейсы по дням (CTE с GROUP BY),
     потом снаружи применяй SUM() OVER (ORDER BY дата)
   • не забудь: в нарастающих итогах порядок должен быть однозначным

   Это тот самый приём "история остатка", только про рейсы.
   ===================================================================== */

WITH count_date AS (SELECT t.scheduled_departure::DATE as date_dep, COUNT(t.flight_id) as count_fl
                    FROM timetable t
                    GROUP BY t.scheduled_departure::DATE)
SELECT c.date_dep, c.count_fl, SUM(c.count_fl) OVER (ORDER BY c.date_dep) AS running_total
FROM count_date c
ORDER BY c.date_dep;
