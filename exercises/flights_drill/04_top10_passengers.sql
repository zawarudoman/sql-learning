/* DRILL 4 — JOIN + GROUP BY + LIMIT
   Топ-10 пассажиров по числу перелётов.
   Столбцы: имя пассажира, число перелётов. Больше — сверху.
   Схема: tickets (ticket_no, passenger_name) → segments (ticket_no).
   (Один перелёт = одна строка в segments.) */

SELECT t.passenger_name ,COUNT(*) as cnt_flight from tickets t
GROUP BY t.passenger_name order by cnt_flight DESC LIMIT 10

