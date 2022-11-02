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

class User
  attr_accessor :id, :fname, :ln

  def self.find_by_id(id)

    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM 
        users
      WHERE 
        id = ?
    SQL

    return nil unless user.length > 0

    User.new(user.first)
  end
  
  def self.find_by_name(fname, lname)

    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM 
        users
      WHERE 
        fname = ? AND lname = ?
    SQL

    user.map { |name| User.new(name) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end


 
  
end

