/* =====================================================================
   PRACTICE 1. Аэропорты страны
   Навык: WHERE + ORDER BY (базовый SELECT)
   ---------------------------------------------------------------------
   Выведи код, город и название всех аэропортов России.
   Отсортируй по городу.

   Схема: airports (airport_code, airport_name, city, country).
   Страна лежит в поле country (текст, напр. 'Russia').
   ===================================================================== */

SELECT a.airport_code as code, a.city as city, a.airport_name as airport
FROM airports a
where a.country = 'Russia'
ORDER BY city