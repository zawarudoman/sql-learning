# SQL Learning

Мой учебный репозиторий: путь от DB-разработчика к Analytics / Data Engineer.

## Полигон

Тренируюсь на **демо-базе «Авиаперевозки»** от Postgres Professional
(версия `demo-20250901-6m` — 6 месяцев данных, PostgreSQL 17).

Подключение: `localhost:5432`, база `demo`, схема `bookings`.

### Схема (версия 2025 — отличается от туториалов в интернете!)

```
bookings (book_ref, book_date, total_amount)
   └─ tickets (ticket_no, book_ref, passenger_name, outbound)
        └─ segments (ticket_no + flight_id, fare_conditions, price)
             └─ flights (flight_id, route_no, status,
                         scheduled_/actual_ departure/arrival)
                  └─ routes (route_no, departure_airport, arrival_airport,
                             airplane_code, days_of_week[], scheduled_time,
                             duration, validity)
                       ├─ airports (airport_code, airport_name, city, country, timezone)
                       └─ airplanes (airplane_code, model, range, speed)
                            └─ seats (airplane_code, seat_no, fare_conditions)
boarding_passes (ticket_no + flight_id, seat_no, boarding_no, boarding_time)
```

Плюс готовое представление **`timetable`** — `flights` + `routes` + `airports` с местным временем.

⚠️ **Переименования vs старая схема** (важно, статьи в интернете используют старую):

| Старая (в туториалах) | Здесь (2025) |
|-----------------------|--------------|
| `aircrafts` | `airplanes` |
| `ticket_flights` | `segments` |
| `amount` | `price` |
| `flights.flight_no` | `routes.route_no` |
| `flights.departure_airport` / `arrival_airport` / `aircraft_code` | переехали в `routes` |
| `routes` (было VIEW) | теперь таблица |

## Структура репозитория

| Папка | Что внутри |
|-------|-----------|
| `exercises/flights/` | решения задач по демо-базе |
| `notes/` | конспекты и справочники |
| `dbt/` | dbt-проект (Фаза 2) |
| `python/` | скрипты на Python (Фаза 3) |

## План

1. **Фаза 1** — SQL до уровня «не подкопаешься»: CTE, оконные функции, `EXPLAIN`/индексы, множества, пивоты.
2. **Фаза 2** — dbt: модели, тесты, витрины.
3. **Фаза 3** — Python + pandas, мини-ETL.
4. **Капстоун** — сквозной аналитический конвейер.

## Правила

- Работаю с двух машин (Windows + macOS): **`git pull` перед началом, `git push` перед уходом.**
- В репозиторий **не попадают**: пароли, строки подключения, выгрузки данных, рабочий код компании.
