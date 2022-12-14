require_relative "aa.rb"
require_relative "user.rb"
require_relative "reply.rb"
require_relative "question_follow.rb"

class Question 
    attr_accessor :id, :title, :body, :author_id
  
    def self.find_by_id(id)
      question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM 
          questions
        WHERE 
          id = ?
      SQL
  
      return nil unless question.length > 0
      Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT
            *
          FROM 
            questions
          WHERE 
            author_id = ?
        SQL

        questions.map { |question| Question.new(question) }
    end

    def initialize(options)
      @id = options['id']
      @title = options['title']
      @body = options['body']
      @author_id = options['author_id']
    end

    def author
      User.find_by_id(author_id)
    end

    def replies
      Reply.find_by_question_id(id)
    end

    def followers
      QuestionFollow.followers_for_question_id(id)
    end
end

