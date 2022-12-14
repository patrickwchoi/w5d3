require_relative "aa.rb"
require_relative "user.rb"
require_relative "question.rb"

class Reply
    attr_accessor :id, :question_id, :parent_id, :body, :user_id
  
    def self.find_by_id(id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM 
          replies
        WHERE 
          id = ?
      SQL
  
      return nil unless reply.length > 0
      Reply.new(reply.first)
    end

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM 
          replies
        WHERE 
          user_id = ?
      SQL
  
        replies.map { |reply| Reply.new(reply) } 
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM 
          replies
        WHERE 
          question_id = ?
      SQL
  
        replies.map { |reply| Reply.new(reply) } 
    end

  
    def initialize(options)
      @id = options['id']
      @question_id = options['question_id']
      @parent_id = options['parent_id']
      @body = options['body']
      @user_id = options['user_id']
    end

    def author
      User.find_by_id(user_id)
    end

    def question
      Question.find_by_id(question_id)
    end

    def parent_reply
      Reply.find_by_id(parent_id)
    end

    def child_replies
      all_replies = Reply.find_by_question_id(question_id)
      all_replies.select { |reply| self.id == reply.parent_id}
    end
  end
