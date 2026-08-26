/* =====================================================================
   ЭКЗАМЕН 1 · Задача 7 (15 баллов)
   ---------------------------------------------------------------------
   Динамика выручки по месяцам.

   Для каждого месяца выведи:
     • месяц (чистая дата, без времени),
     • выручку месяца,
     • выручку предыдущего месяца,
     • прирост к предыдущему месяцу в процентах (округли до 2 знаков).

   Отсортируй по месяцу от старых к новым.

   Выручка = SUM(segments.price), месяц определяется по дате
   планового вылета рейса.
   ===================================================================== */

/*ТАКУЮ ЗАДАЧУ Я УЖЕ ДЕЛАЛ ТАК ЧТО ПРОСТО СКОПИРОВАЛ*/

select dat_month::date,
       price,
       prev_price,
       round((price - prev_price) / prev_price * 100, 2) as percent
from (WITH sum_month as (SELECT SUM(s.price)                               as price,
                                date_trunc('month', f.scheduled_departure) as dat_month
                         FROM segments s
                                  JOIN flights f ON s.flight_id = f.flight_id
                         GROUP BY date_trunc('month', f.scheduled_departure)
                         ORDER BY dat_month)
      SELECT sm.*, lag(sm.price, 1) OVER (ORDER BY sm.dat_month ) as prev_price
      FROM sum_month sm) as alias
ORDER BY dat_month