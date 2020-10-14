require "pg"

class Bookmark
  attr_reader :title, :url, :id

  def initialize(title:, url:, id:)
    @title = title
    @url = url
    @id = id
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    rs = conn.exec "SELECT * FROM bookmarks"
    rs.map do |bookmark|
      new(title: bookmark["title"], url: bookmark["url"], id: bookmark["id"])
    end
  end

  def self.create(title:, url:)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    conn.exec "INSERT INTO bookmarks(title,url) VALUES('#{title}','#{url}')"
  end

  def self.delete(id)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    conn.exec "DELETE FROM bookmarks WHERE id = '#{id}'"
  end

  def self.update(id: ,title: ,url: )
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    conn.exec "UPDATE bookmarks SET id = '#{id}', url = '#{url}', title = '#{title}' WHERE id = '#{id}'"
  end

  def self.find(id)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    rs = conn.exec "SELECT * FROM bookmarks WHERE id = '#{id}'"
    rs.map do |bookmark|
      new(title: bookmark["title"], url: bookmark["url"], id: bookmark["id"])
    end.pop
  end
end
