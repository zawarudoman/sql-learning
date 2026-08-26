/* =====================================================================
   PRACTICE 4. Бронирования дороже среднего
   Навык: скалярный подзапрос в WHERE
   ---------------------------------------------------------------------
   Выведи бронирования, чья сумма ВЫШЕ средней суммы по всем бронированиям.
   Столбцы: номер брони, сумма. Дорогие — сверху.

   Подсказка: среднее по всей таблице — это подзапрос, который возвращает
   одно число:  WHERE total_amount > (SELECT AVG(total_amount) FROM bookings)

   Схема: bookings (book_ref, total_amount).
   ===================================================================== */

SELECT b.book_ref     as booking_number
     , b.total_amount as amount
FROM bookings b
WHERE b.total_amount > (SELECT AVG(total_amount) FROM bookings)
order by amount DESC
