import re
with open('init-db/03-seed_data.sql', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace('}{"phone": "{phone}", "email": "{email}", "address": "{street_address}"}', '')
with open('init-db/03-seed_data.sql', 'w', encoding='utf-8') as f:
    f.write(content)
