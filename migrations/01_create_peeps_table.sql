CREATE TABLE peeps(id SERIAL PRIMARY KEY, text VARCHAR(200), account_id INTEGER REFERENCES users (id));