/* =====================================================================
   ЭКЗАМЕН 1 · Задача 8 (20 баллов) — самая дорогая задача
   ---------------------------------------------------------------------
   Компоновка салонов. По каждой модели самолёта выведи В СТОЛБЦАХ:
     • модель,
     • число мест Economy,
     • число мест Comfort,
     • число мест Business,
     • всего мест,
     • долю эконом-класса от всех мест этой модели, в процентах
       (округли до 1 знака).

   Отсортируй по общему числу мест, большие самолёты — сверху.
   Модели, у которых нет какого-то класса, должны показывать 0,
   а не пустоту.
   ===================================================================== */

WITH cnt_seat AS (SELECT ap.model as airplane,
       COUNT(CASE WHEN s.fare_conditions ='Economy' THEN 1 END) as Economy_seat,
       COUNT(CASE WHEN s.fare_conditions ='Comfort' THEN 1 END) as Comfort_seat,
       COUNT(CASE WHEN s.fare_conditions ='Business' THEN 1 END)as Business_seat,
       COUNT(*) AS total_seats
FROM airplanes ap
         JOIN seats s ON s.airplane_code = ap.airplane_code
GROUP BY ap.model)
SELECT *, ROUND(Economy_seat::numeric/total_seats*100, 1) from cnt_seat

