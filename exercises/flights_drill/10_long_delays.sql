/* DRILL 10 — фильтр по вычисленному значению
   Выведи рейсы, задержанные с вылетом БОЛЕЕ чем на 2 часа.
   Столбцы: flight_id, плановый вылет, фактический вылет, задержка (интервал).
   Самые задержанные — сверху, 30 строк.
   Схема: flights (flight_id, scheduled_departure, actual_departure).
   Подсказка: задержка = actual_departure - scheduled_departure;
   "больше 2 часов" сравни с INTERVAL '2 hours'. И вылетевшие только (actual не NULL). */

-- решение:

