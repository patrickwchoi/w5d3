require 'sqlite3'
require 'singleton'

class QuestionsDatabase  < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Users 
  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute((<<-SQL, id)
      SELECT
        *
      FROM 
        users
      WHERE 
        id = ?
    SQL
    return nil unless user.length>0
    User.new(user.first)
  end
  
  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute((<<-SQL, fname, lname)
      SELECT
        *
      FROM 
        users
      WHERE 
        fname = ?,
        lname = ?
    SQL
    return nil unless user.length>0
    User.new(user.first)
  end
  
end

