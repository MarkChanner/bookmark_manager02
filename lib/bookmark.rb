require 'pg'

class Bookmark

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end

    result = con.exec "SELECT url FROM bookmarks"
    result.values.flatten
  end

  def self.add(url)
    return false unless valid_url?(url)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end
    con.exec "INSERT INTO bookmarks (url) VALUES ('#{url}');"
  end

  private

  def self.valid_url?(url)
     !!(url =~ /\A#{URI::regexp}\z/)
  end

end
