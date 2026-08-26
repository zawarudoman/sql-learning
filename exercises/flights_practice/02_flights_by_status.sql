/* =====================================================================
   PRACTICE 2. Рейсы по статусам
   Навык: GROUP BY + COUNT (простой агрегат)
   ---------------------------------------------------------------------
   Посчитай, сколько рейсов в каждом статусе.
   Выведи: статус, число рейсов. Самые частые статусы — сверху.

   Схема: flights (flight_id, status).
   Статусы: 'Scheduled', 'On Time', 'Delayed', 'Departed', 'Arrived',
            'Cancelled', 'Boarding'.
   ===================================================================== */

SELECT f.status, COUNT(f.flight_id) as count_flight
FROM flights f
GROUP BY f.status
ORDER BY count_flight DESC