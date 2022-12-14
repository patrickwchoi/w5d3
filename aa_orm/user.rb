require_relative "aa.rb"
require_relative "question.rb"
require_relative "reply.rb"

class User
    attr_accessor :id, :fname, :lname
  
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
            fname = ? AND lname = ? --'?' corresponds to SQL args in order they appear
                                    -- so here, first ? is fname
        SQL
    
        user.map { |name| User.new(name) }
    end
    
    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        questions = Question.find_by_author_id(id)
        return questions
    end

    def authored_replies
      replies = Reply.find_by_user_id(id)
      return replies
    end

    def followed_questions
      QuestionFollower.followed_questions_for_user_id(id)
    end
    
end