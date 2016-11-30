DROP TABLE IF EXISTS users;
CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Michael', 'Mach'), ('Zidian', 'Lyu');


DROP TABLE IF EXISTS questions;
CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('SQLITE Issues', 'Unable to install SQLITE3', 1),
  ('Tuesday', 'let''s do homework?', 2);


DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 2), (2, 1), (1, 1);



DROP TABLE IF EXISTS replies;
CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent INTEGER NULL,
  -- reply in user_id
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO
  replies(question_id, parent, user_id, body)
VALUES
  (1, NULL, 1, "He is talking"),
  (1, 1, 2, "She is talking");


DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (1, 1), (2, 2), (1, 2);
