/* =====================================================================
   ЭКЗАМЕН 1 · Задача 5 (15 баллов)
   ---------------------------------------------------------------------
   Для КАЖДОГО класса обслуживания найди 3 самых дорогих сегмента.

   Выведи: класс, ticket_no, flight_id, цену, номер места по цене
   внутри класса (1, 2, 3).

   Итого должно получиться не больше 3 строк на класс.
   Отсортируй по классу, затем по номеру.
   ===================================================================== */

SELECT  sb.fare_conditions, sb.ticket_numder, sb.flight_id, sb.price_ticket, sb.seat_number
FROM (SELECT s.fare_conditions as fare_conditions,
             s.ticket_no as ticket_numder,
             s.flight_id as flight_id,
             s.price as price_ticket,
             bs.seat_no as seat_number,
             row_number() over (PARTITION BY s.fare_conditions ORDER BY s.price) as rn
      FROM segments s
               JOIN boarding_passes bs ON s.ticket_no = bs.ticket_no) as sb
WHERE sb.rn in (1, 2, 3)

