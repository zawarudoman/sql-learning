/* =====================================================================
   HARD 2. Выручка по моделям самолётов — ловушка фан-аута
   Темы: JOIN нескольких таблиц, риск задвоения агрегата
   ---------------------------------------------------------------------
   ЗАДАЧА:
   Посчитай суммарную выручку (segments.price) по каждой модели самолёта.
   Столбцы: модель, суммарная выручка, число проданных сегментов.
   Больше выручки — выше.

   Цепочка связей:
     segments (price, flight_id)
       → flights (flight_id, route_no)
         → routes (route_no, airplane_code)
           → airplanes (airplane_code, model)

   ⚠️ Ловушка: тут ЧЕТЫРЕ таблицы в цепочке. Легко получить неверную сумму,
   если где-то связь "один-ко-многим" размножит строки. После того как
   напишешь — ПРОВЕРЬ себя: посчитай общую SUM(price) по всей segments
   одним простым запросом и сравни с суммой всех строк своего отчёта.
   Совпало? Если нет — ты поймал фан-аут, ищи, какой JOIN дублирует.

   Подсказка: сначала проверь, точно ли каждая связь однозначна
   (один flight → один route → один airplane?), или где-то один-ко-многим.
   ===================================================================== */

WITH flight_plane AS (
    SELECT f.flight_id,
           r.airplane_code
    FROM bookings.flights f
        JOIN bookings.routes r
            ON  r.route_no = f.route_no
            AND f.scheduled_departure::date <@ r.validity
            AND EXTRACT(isodow FROM f.scheduled_departure)::int = ANY (r.days_of_week)
)
SELECT a.model,
       SUM(s.price) AS revenue,
       COUNT(*)     AS segments_cnt
FROM bookings.segments s
    JOIN flight_plane       fp ON fp.flight_id     = s.flight_id
    JOIN bookings.airplanes a  ON a.airplane_code  = fp.airplane_code
GROUP BY a.model
ORDER BY revenue DESC;