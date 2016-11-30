require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    # self.type_translation = true
    # self.results_as_hash = true
  end


end

















class User
  attr_accessor :fname, :lname
  attr_reader :id
  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = users.id
    SQL
  end

  def self.find_by_name(fname, lname)
    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = users.fname
      AND
        ? = users.lname
    SQL
  end

  def initialize(options)
    @id, @fname, @lname = options.values_at(:id, :fname, :lname)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end

  def average_karma
    id = @id
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        CAST((COUNT(ql.user_id) / COUNT(DISTINCT(quest.id))) AS FLOAT)
      FROM
        questions quest
      LEFT JOIN
        question_likes ql
      ON
        ql.question_id = quest.id
      WHERE
        quest.user_id = ?
    SQL
  end

  def save
    @id ? update : create
  end

  def update
    id = @id
    QuestionsDatabase.instance.execute(<<-SQL, attributes, id)
      UPDATE
        users
      SET
        fname = ?,
        lname = ?
      WHERE
        users.id = ?
    SQL
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, attributes)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL
  end

  def attributes
    [@fname, @lname]
  end
end

















class Question
  attr_accessor :title, :body, :user_id
  attr_reader :id
  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = questions.id
    SQL
  end

  def self.find_by_author_id(author_id)
    QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        ? = questions.user_id
    SQL
  end

  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end

  def initialize(options)
    @id, @title, @body, @user_id =
      options.values_at(:id, :title, :body, :user_id)
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end

  def likers
    QuestionLikes.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(@id)
  end

  def save
    @id ? update : create
  end

  def update
    id = @id
    QuestionsDatabase.instance.execute(<<-SQL, attributes, id)
      UPDATE
        questions
      SET
        title = ?,
        body = ?,
        user_id = ?
      WHERE
        questions.id = ?
    SQL
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, attributes)
      INSERT INTO
        questions(title, body. user_id)
      VALUES
        (?, ?, ?)
    SQL
  end

  def attributes
    [@title, @body, @user_id]
  end
end




















class QuestionFollows
  attr_accessor :user_id, :question_id
  attr_reader :id
  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = question_follows.id
    SQL
  end

  def self.followers_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM
        question_follows
      JOIN
        users
      ON
        users.id = question_follows.user_id
      WHERE
        ? = question_follows.question_id
    SQL
  end

  def self.followed_questions_for_user_id(user_id)
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.user_id
      FROM
        questions
      JOIN
        question_follows
      ON
        question_follows.question_id = questions.id
      WHERE
        ? = question_follows.user_id

    SQL
  end


  def self.most_followed_questions(n)
    QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.body,
        COUNT(*)
      FROM
        questions
      JOIN
        question_follows
      ON
        question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
  end

  def initialize(options)
    @id, @user_id, @question_id =
      options.values_at(:id, :user_id, :question_id)
  end
end




















class Reply
  attr_accessor :question_id, :body, :user_id, :parent
  attr_reader :id
  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = replies.id
    SQL
  end

  def self.find_by_user_id(user_id)
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        ? = replies.user_id
    SQL
  end

  def self.find_by_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        ? = replies.question_id
    SQL
  end


  def initialize(options)
    @id, @question_id, @body, @user_id, @parent =
      options.values_at(:id, :question_id, :body, :user_id, :parent)
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent)
  end

  def child_replies
    Reply.find_by_id(id)
  end

  def save
    @id ? update : create
  end

  def update
    id = @id
    QuestionsDatabase.instance.execute(<<-SQL, attributes, id)
      UPDATE
        replies
      SET
        question_id = ?,
        body = ?,
        user_id = ?,
        parent = ?
      WHERE
        replies.id = ?
    SQL
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, attributes)
      INSERT INTO
        replies(question_id, body, user_id, parent)
      VALUES
        (?, ?, ?, ?)
    SQL
  end

  def attributes
    [@question_id, @body, @user_id, @parent]
  end
end




















class QuestionLikes
  attr_accessor :user_id, :question_id
  attr_reader :id
  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        -- ? is the id we take in from (<<-SQL, id), basically the 'id'
        ? = question_likes.id
    SQL
  end

  def self.likers_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes AS ql
      JOIN
        users
      ON
        users.id = ql.user_id
      WHERE
        ql.question_id = ?

    SQL
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        question_likes.question_id,
        COUNT(*)
      FROM
        question_likes

      WHERE
        question_likes.question_id = ?
      GROUP BY
        question_likes.question_id
    SQL
  end


  def self.liked_questions_for_user_id(user_id)
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
  end

  def self.most_liked_questions(n)
    QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.body,
        COUNT(*)
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
  end


  def initialize(options)
    @id, @user_id, @question_id = options.values_at(:id, :user_id, :question_id)
  end
end
