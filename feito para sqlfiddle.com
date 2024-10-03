CREATE TABLE genre ( 
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE developer (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  founded TEXT,
  country VARCHAR(50)
);

CREATE TABLE game (
  id SERIAL PRIMARY KEY,
  genre_id INTEGER REFERENCES genre(id),
  release_date DATE, 
  description TEXT
);

CREATE TABLE developer_game (
  developer_id INTEGER REFERENCES developer(id),
  game_id INTEGER REFERENCES game(id),
  PRIMARY KEY (developer_id, game_id)  
);

CREATE TABLE review (
  id SERIAL PRIMARY KEY,
  game_id INTEGER REFERENCES game(id),
  stars INTEGER, 
  comment TEXT
);

INSERT INTO genre (name) VALUES
  ('Aventura'),
  ('Ação'),
  ('RPG');

INSERT INTO developer (name, founded, country) VALUES
  ('Stardew Valley', 'Eric Barone ', 'Estados Unidos'),
  ('GTA V', 'Rockstar North', 'Britânia'),
  ('Albion online', 'Sandbox Interactive', 'Alemanha');

INSERT INTO game (genre_id, release_date, description) VALUES
  (1, '2016-02-26', 'Um jogo de fazenda e aventura com lugares desconhecidos.'),
  (2, '2013-07-17', 'Um completo mundo aberto com muitas opções de coisas para fazer.'),
  (3, '2017-06-17', 'Um RPG que oferece escolhas profundas e um mundo rico.');

SELECT * FROM developer;
SELECT * FROM game;
