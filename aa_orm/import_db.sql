PRAGMA foreign_keys = ON;
-- DROP TABLE IF EXISTS ;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO 
  users (id, fname, lname)
VALUES
  (1, 'Patrick', 'Choi'),
  (2, 'Andrea', 'Cano');

INSERT INTO
  questions (id, title, body, author)
VALUES
  (1, 'How to bath a cat?', 'How do I wash my cat for the first time?', 'Patrick'),
  (2, 'How to adopt a dog?', 'Can someone help me to adopt a dog?', 'Andrea'),
  (3, 'How to play the guitar?', 'I am a beginner. Where Can I learn how to play the guitar?', 'Andrea');

INSERT INTO 
  question_follows (user_id, question_id)
VALUES 
  (1, 1),
  (2, 2),
  (3, 2);

INSERT INTO 
  replies (id, question_id, parent_id, body, user_id)
VALUES
  (1, 1, NULL, 'be very gentle and careful', 2),
  (2, 2, NULL, 'make an appt with a shelter' 1),
  (3, 2, 2, 'Do you know a shleter nearby?', 2);


INSERT INTO 
  question_likes (id, user_id, question_id)
VALUES
  (1, 2, 1),
  (2, 1, 2),
  (3, 2, 3);

