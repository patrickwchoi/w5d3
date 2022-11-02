require_relative "aa.rb"
require_relative "user.rb"
require_relative "question.rb"

class QuestionFollow
  attr_accessor :id, :question_id, :user_id

  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM 
        question_follows
      WHERE 
        id = ?
    SQL

    return nil unless question_follow.length > 0
    QuestionFollow.new(question_follow.first)
  end

  def self.followers_for_question_id(question_id)
    users_follow_q = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            qf.user_id AS id, fname, lname
        FROM
            question_follows AS qf
        JOIN users ON qf.user_id = users.id
        WHERE 
            question_id = ?
    SQL

    users_follow_q.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_user_follows = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
        questions.id, title, body, author_id
        FROM
            question_follows AS qf
        JOIN questions ON qf.question_id = questions.id
        WHERE 
            user_id = ?
    SQL

    question_user_follows.map { |question| Question.new(question) }

  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end