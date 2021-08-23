# online-shop
1) Структура базы интернет-магазина tables.sql
 
2) Запросы queries.sql

- Запрос 1
```
Цель: Список клиентов (ФИО)
Условие: совершали заказы в период с 01.01.18 по 02.01.18
В заказах был товар X, производителя Y
``` 
- Запрос 2
```
Цель: Список заказов от клиентов с именем Иван
Условие: Совершали заказы в период с 01.01.18 по 02.01.18
Сумма заказов от клиентов за период больше или равно 10 000 руб.
В заказах не было товара X, но был товар Y
``` 
- Запрос 3
```
Цель: Список клиентов, не совершающих покупки на протяжении 6 месяцев
Условия: Клиенты, которые были с оборотом выше среднего в аналогичном периоде прошлого года
Данные клиенты из топ-3 регионов по продажам
```
- Запрос 4
```
Цель: Список заказов с условно проблемными доставками
Условие: Доставка была сделана на этой неделе водителями с плохими откликами за текущий месяц от клиентов
Данные клиенты - высокодоходные за все время работы
```
