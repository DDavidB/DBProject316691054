with open('init-db/03-seed_data.sql', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace('"address": "{street_address}"\'', '"address": "{street_address}"}''')
with open('init-db/03-seed_data.sql', 'w', encoding='utf-8') as f:
    f.write(content)
