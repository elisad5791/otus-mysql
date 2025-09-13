# Добавляем в модель данных дополнительные индексы и ограничения

### Ограничения

Добавлены ограничения

UNIQUE
- categories(title)
- producers(title)
- suppliers(title)

NOT NULL
- products(producer_id)
- products(supplier_id)

UNSIGNED
- prices(value)
- purchase_items(quantity)
- purchase_items(unit_price)

CHECK
- phones(phone)
- emails(email)

Также в таблицах уже есть ограничения внешнего ключа
FOREIGN KEY

### Индексы