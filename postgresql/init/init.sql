--テーブルを作成
CREATE TABLE public.book (
  id integer, 
  name varchar(255),
  PRIMARY KEY (id)
);

--スキーマの作成
CREATE schema schema1;
SET search_path TO schema1, public;
--テーブルを作成
CREATE TABLE schema1.book (
  id integer, 
  name varchar(255),
  PRIMARY KEY (id)
);
--テーブルにデータを挿入
INSERT INTO schema1.book VALUES (1,'Alice''s Adventures in Wonderland');
INSERT INTO schema1.book VALUES (2,'THE COMPLETE WORKS OF ERNEST HEMINGWAY');
INSERT INTO schema1.book VALUES (3,'Off on a Comet');
INSERT INTO schema1.book VALUES (4,'THE OLD MAN AND THE SEA');
INSERT INTO schema1.book VALUES (5,'The Alchemist');

--スキーマの作成
CREATE schema schema2;
SET search_path TO schema2, public;

--テーブルを作成
CREATE TABLE schema2.book (
  id integer, 
  name varchar(255),
  PRIMARY KEY (id)
);
--テーブルにデータを挿入
INSERT INTO schema2.book VALUES (1,'The Merry-Go-Round');
INSERT INTO schema2.book VALUES (2,'The Book of Marvels and Travels');
INSERT INTO schema2.book VALUES (3,'Norse Mythology');
INSERT INTO schema2.book VALUES (4,'Grimm''s Complete Fairy Tales');
INSERT INTO schema2.book VALUES (5,'The Wonderful Wizard of Oz');
