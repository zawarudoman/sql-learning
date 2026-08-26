/* =====================================================================
   ANALYST 2. Средний чек бронирования по месяцам
   ---------------------------------------------------------------------
   БИЗНЕС-ВОПРОС:
   Сколько бронирований оформляли каждый месяц, на какую сумму,
   и какой средний чек?

   ЧТО ВЫВЕСТИ:
   • месяц (date_trunc('month', book_date)),
   • число бронирований,
   • суммарная сумма (SUM total_amount),
   • средний чек (AVG total_amount, round 2).
   Отсортируй по месяцу.

   ГДЕ ДАННЫЕ:
   • одна таблица bookings (book_ref, book_date, total_amount) — JOIN не нужен.

   Задача простая по структуре — это разминка на date_trunc + агрегаты.
   Но сделай красиво: округли, дай осмысленные имена.
   ===================================================================== */

SELECT date_trunc('month', b.book_date)::date as month,
       COUNT(*)                               as cnt_booking,
       SUM(b.total_amount)                    as sum_booking,
       ROUND(AVG(b.total_amount), 2)          as avg_booking
FROM bookings b
GROUP BY date_trunc('month', b.book_date)
ORDER BY month

