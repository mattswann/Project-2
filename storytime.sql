CREATE DATABASE storytime;

\c storytime

CREATE TABLE stories (
 id SERIAL4 PRIMARY KEY,
 title VARCHAR(100) NOT NULL,
 author VARCHAR(50) NOT NULL,
 genre VARCHAR NOT NULL,
 createdate DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE chapters (
  id SERIAL4 PRIMARY KEY,
  chaptername varchar(50),
  body TEXT,
  story_id integer
);

INSERT INTO chapters (chapterauthor);