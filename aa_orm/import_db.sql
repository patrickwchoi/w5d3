PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INT NOT NULL PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL

  FOREIGN KEY id REFERENCES question_follows(users_id)
) ;


CREATE TABLE questions (
  id INT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  author TEXT NOT NULL,

  FOREIGN KEY (id) REFERENCES question_follows(question_id)
);

CREATE TABLE question_follows (
  question_id INT PRIMARY KEY
  users_id INT 
);

CREATE TABLE replies (
  id INT NOT NULL PRIMARY KEY
  question_id INT NOT NULL
  parent_id INT 
  body TEXT NOT NULL
  users_id INT NOT NULL

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INT NOT NULL PRIMARY KEY
  users_id INT NOT NULL 
  question_id INT NOT NULL

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (users_id) REFERENCES users(id)
)

INSERT INTO 
  question_follows (users_id, question_id)
VALUES 
  (1, 1)
  (2, 2)
  (3, 2);


INSERT INTO 
  users (id, fname, lname)
VALUES
  (1, 'Patrick', 'Choi')
  (2, 'Andrea', 'Cano');


INSERT INTO
  questions (id, title, body, author)
VALUES
  (1, 'How to bath a cat?', 'How do I wash my cat for the first time?', 'Patrick')
  (2, 'How to adopt a dog?', 'Can someone help me to adopt a dog?', 'Andrea')
  (3, 'How to play the guitar?', 'I am a beginner. Where Can I learn how to play the guitar?', 'Andrea');


INSERT INTO 
  replies (id, question_id, parent_id, body, users_id)
VALUES
  (1, 1, NULL, 'be very gentle and careful', 2)
  (2, 2, NULL, 'make an appt with a shelter' 1)
  (3, 2, 2, 'Do you know a shleter nearby?', 2);


INSERT INTO 
  question_likes (id, users_id, question_id)
VALUES
  (1, 2, 1)
  (2, 1, 2)
  (3, 2, 3)

  






