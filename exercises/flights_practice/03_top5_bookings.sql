/* =====================================================================
   PRACTICE 3. Топ-5 самых дорогих бронирований
   Навык: ORDER BY DESC + LIMIT
   ---------------------------------------------------------------------
   Выведи 5 бронирований с самой большой суммой.
   Столбцы: номер брони, дата, сумма. Самые дорогие — сверху.

   Схема: bookings (book_ref, book_date, total_amount). Одна таблица, без JOIN.
   ===================================================================== */

SELECT b.book_ref     as booking_number
     , b.book_date    as date
     , b.total_amount as amount
FROM bookings b
ORDER BY b.total_amount DESC
LIMIT 5



