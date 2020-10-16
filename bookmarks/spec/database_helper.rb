def clear_database
  conn = PG.connect( dbname: 'bookmark_manager_test' )
  conn.exec "TRUNCATE TABLE comments, bookmarks"
end
