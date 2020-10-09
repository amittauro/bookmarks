require "pg"

class Bookmark
  attr_reader :title, :url

  def initialize(title:, url:)
    @title = title
    @url = url
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect( dbname: 'bookmark_manager_test' )
    else
      conn = PG.connect( dbname: 'bookmark_manager' )
    end
    rs = conn.exec "SELECT * FROM bookmarks"
    rs.map do |bookmark|
      new(title: bookmark["title"], url: bookmark["url"])
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
end
