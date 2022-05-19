CREATE DATABASE inspiration_board;
\c inspiration_board

CREATE TABLE home_pictures(
    id SERIAL PRIMARY KEY,
    image_url TEXT,
    posted_by TEXT
);

INSERT INTO home_pictures(image_url, title, posted_by)
VALUES ('https://images.unsplash.com/photo-1505744288177-8a097ba01de0?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=385', 'Wedding Reception Centerpiece', 'Kelly Sikkema'), ('https://images.unsplash.com/photo-1567225557594-88d73e55f2cb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', 'Architecture & Interior', 'Minh Pham');

CREATE TABLE boards(
    id SERIAL PRIMARY KEY,
    image_url TEXT,
    title TEXT,
    posted_by TEXT
);

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT
);

ALTER TABLE users ADD COLUMN password_digest TEXT;
