CREATE DATABASE inspiration_board;
\c inspiration_board

CREATE TABLE home_pictures(
    id SERIAL PRIMARY KEY,
    image_url TEXT,
    posted_by TEXT
);

INSERT INTO home_pictures(image_url, posted_by)
VALUES ('https://img.freepik.com/free-photo/social-media-audience-crowd-filming-through-smartphones-remixed-media_53876-128943.jpg?w=826&t=st=1653184604~exp=1653185204~hmac=a06d97a79f3b1c2bdc510a3119e51b398d32a07f1190ebe51d7ee98373490ec4', 'Designed by Freepik');



CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password_digest TEXT
);

CREATE TABLE boards(
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    board_title TEXT
);

CREATE TABLE images (
    id SERIAL PRIMARY KEY,
    board_id INTEGER,
    image_url TEXT
);


-- Write this on the terminal to push:
-- heroku pg:reset
-- heroku pg:push inspiration_board DATABASE_URL

