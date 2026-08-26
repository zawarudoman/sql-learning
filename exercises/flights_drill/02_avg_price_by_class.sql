/* DRILL 2 — GROUP BY + AVG
   Средняя цена сегмента по каждому классу обслуживания.
   Столбцы: класс, средняя цена (round 2), число сегментов. Дороже — сверху.
   Схема: segments (fare_conditions, price). */

WITH avg AS (SELECT s.fare_conditions as class, ROUND(AVG(s.price), 2) as avg_price
             FROM segments s
             GROUP BY s.fare_conditions
             ORDER BY avg_price DESC)
SELECT row_number() over (ORDER BY a.avg_price DESC) as number, a.*
from avg a

