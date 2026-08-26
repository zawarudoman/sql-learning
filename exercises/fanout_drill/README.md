# ДРИЛЛ: фан-аут

Пять задач. В **четырёх** спрятана ловушка размножения строк — в каждой своя разновидность.
В **одной** ловушки нет вообще: она нужна, чтобы ты не начал видеть фан-аут там, где его нет.
Какая именно — не скажу.

## Правила

В каждом файле есть обязательный блок `-- ПРОВЕРКА`. Заполнять **до** написания агрегатов:

```sql
-- ПРОВЕРКА
-- строк в фактовой таблице (или до JOIN):  ______
-- строк после JOIN:                        ______
-- совпало? да / нет
-- если нет — какой JOIN размножил и почему: ______
```

Решение без заполненной проверки не засчитывается. Смысл дрилла именно в ней.

## Диагностика — два запроса

```sql
-- А. сколько строк на ключ в справочнике
SELECT <ключ>, count(*) FROM <справочник>
GROUP BY <ключ> HAVING count(*) > 1 LIMIT 10;

-- Б. количество строк до и после JOIN
SELECT count(*) FROM <факты>;
SELECT count(*) FROM <факты> JOIN <справочник> ON ...;
```

## Пять способов лечения

| # | Способ | Когда |
|---|--------|-------|
| 1 | Не джойнить вообще | поле уже есть в фактовой таблице |
| 2 | Сузить справочник (`DISTINCT` / `row_number = 1`) | нужна одна версия из многих |
| 3 | Достроить условие связи до полного ключа | версионированный справочник |
| 4 | Агрегировать ДО джойна (CTE) | две таблицы «многих» к одному родителю |
| 5 | `EXISTS` вместо `JOIN` | справочник нужен только для фильтра |

`COUNT(DISTINCT ...)` лечением **не считается** — он маскирует симптом и не спасает `SUM`.

## Схема

```
airports        (airport_code, airport_name, city, country)
airplanes       (airplane_code, model, range, speed)
seats           (airplane_code, seat_no, fare_conditions)
routes          (route_no, departure_airport, arrival_airport, airplane_code,
                 days_of_week, validity)        -- ВЕРСИОНИРОВАННАЯ
flights         (flight_id, route_no, scheduled_departure, actual_departure, status)
segments        (ticket_no, flight_id, fare_conditions, price)
boarding_passes (ticket_no, flight_id, boarding_no, seat_no)
timetable       (вьюха: flight_id, route_no, scheduled_departure, actual_departure,
                 departure_airport, arrival_airport, status, ...)
```
