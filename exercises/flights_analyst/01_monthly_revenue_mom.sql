/* =====================================================================
   ANALYST 1. Помесячная выручка и рост «месяц к месяцу»
   Уровень: аналитик с опытом. Многошагово, но без ловушек.
   ---------------------------------------------------------------------
   БИЗНЕС-ВОПРОС:
   Как менялась выручка по месяцам и на сколько % она росла/падала
   относительно предыдущего месяца?

   ЧТО ВЫВЕСТИ:
   • месяц (началом месяца, напр. 2025-08-01),
   • выручка за месяц,
   • выручка предыдущего месяца,
   • прирост в % к предыдущему месяцу (round, 1 знак).
   Отсортируй по месяцу.

   ГДЕ ДАННЫЕ:
   • выручка = SUM(segments.price);
   • месяц рейса = date_trunc('month', flights.scheduled_departure);
   • segments.flight_id → flights.flight_id.

   ТЕХНИКА (всё это ты уже умеешь):
   • CTE: сначала выручка по месяцам (JOIN + GROUP BY date_trunc);
   • снаружи: lag() для «предыдущего месяца» + расчёт %.
   • не забудь про дробное деление (100.0) и что у первого месяца
     предыдущего нет → прирост будет NULL, это нормально.
   ===================================================================== */

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

