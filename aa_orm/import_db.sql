

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

  FOREIGN KEY (id) REFERENCES question_follows(questions_id)
);

CREATE TABLE question_follows (
  users_id INT PRIMARY KEY
  questions_id INT PRIMARY KEY
);

CREATE TABLE replies (
  reply_id INT NOT NULL PRIMARY KEY
  questions_id INT NOT NULL
  parent_id INT 
  body TEXT NOT NULL
  users_id INT NOT NULL

  FOREIGN KEY (questions_id) REFERENCES questions(id)
  FOREIGN KEY (users_id) REFERENCES users(id)
);
