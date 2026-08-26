/* DRILL 7 — JOIN + GROUP BY + HAVING
   Города прилёта, суммарная выручка которых больше 1 000 000.
   Столбцы: город, выручка. Больше — сверху.
   Схема: segments (price, flight_id) → timetable (flight_id, arrival_airport)
          → airports (airport_code, city).
   (Используй timetable, чтобы не воевать с routes.) */

-- решение:

