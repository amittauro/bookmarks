CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content VARCHAR(240),
  bookmark_id INT,
  FOREIGN KEY(bookmark_id) REFERENCES bookmarks(id)
);