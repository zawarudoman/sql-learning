/* DRILL 1 — фильтр + период + COUNT
   Сколько рейсов со статусом 'Arrived' было запланировано к вылету
   в АВГУСТЕ 2025? Верни одно число.
   Схема: flights (status, scheduled_departure).
   Напоминание: период по timestamp — через >= начало AND < конец+месяц. */


SELECT COUNT(*) as cnt_flight
FROM flights f
WHERE f.status = 'Arrived'
  AND f.scheduled_departure::date >= '2025-08-01'
  and f.scheduled_departure::date < '2025-09-01';

