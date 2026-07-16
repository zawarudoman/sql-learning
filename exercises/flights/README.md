# Фаза 1 — задания на демо-базе «Авиаперевозки»

База: `demo`, схема `bookings`. Решения пишу прямо в файлы, потом коммичу.

## Чек-лист

| № | Файл | Тема | Готово |
|---|------|------|:------:|
| 1 | `01_joins_cities.sql` | JOIN одной таблицы дважды | ✅ |
| 2 | `02_group_by_top_cities.sql` | GROUP BY + агрегат | ☐ |
| 3 | `03_having_seats.sql` | HAVING (фильтр по агрегату) | ☐ |
| 4 | `04_not_exists_unused_airports.sql` | NOT EXISTS | ☐ |
| 5 | `05_cte_intro_delays.sql` | ⭐ CTE (WITH) — знакомство | ☐ |
| 6 | `06_cte_avg_delay_by_city.sql` | CTE + агрегаты + HAVING | ☐ |
| 7 | `07_window_row_number.sql` | ⭐ Оконные: row_number | ☐ |
| 8 | `08_window_running_total.sql` | Оконные: нарастающий итог | ☐ |
| 9 | `09_window_first_per_group.sql` | ⭐ Идиома «одна строка на группу» | ☐ |
| 10 | `10_window_lag_gap.sql` | Оконные: lag | ☐ |
| 11 | `11_set_operations.sql` | ⭐ Множества: EXCEPT / UNION | ☐ |
| 12 | `12_pivot_seats_by_class.sql` | ⭐ Пивот: строки → столбцы | ☐ |
| 13 | `13_explain_indexes.sql` | ⭐ EXPLAIN, индексы, планы | ☐ |

⭐ = новая тема

## Как работаю
1. `git pull`
2. Открываю файл, пишу решение под комментарием, гоняю в DataGrip.
3. Отмечаю галку в чек-листе.
4. `git add -A && git commit -m "задание N" && git push`

## Шпаргалка по схеме
```
bookings → tickets → segments → flights → routes → airports / airplanes → seats
                                    ↑
                         boarding_passes (ticket_no + flight_id)
```
- Аэропорты **не** во `flights`, а в **`routes`** (связь по `route_no`).
- Задержка вылета = `actual_departure - scheduled_departure` (у неулетевших — NULL).
- Задержка в минутах: `EXTRACT(EPOCH FROM (actual_departure - scheduled_departure)) / 60`
- Есть готовое представление **`timetable`** — flights + routes + airports + местное время.
