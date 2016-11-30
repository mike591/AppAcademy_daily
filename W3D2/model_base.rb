class ModelBase

  def self.title
    self.to_s.downcase << 's'
  end

  def self.all
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{title}
    SQL
  end

  def self.find_by_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{title}
      WHERE
        id = ?
    SQL
  end

  def save
    @id ? update : create
  end

  def generate_question_marks
    s = "("
    (instance_variables.size - 1).times do
      s << '?'
      s << ','
    end
    s.slice!(-1)
    s << ')'
    s
  end

  def generate_names
    result = ''
    instance_variables.each_with_index do |el, idx|
      result << el[1..-1].to_s unless idx == 0
      result << ', ' unless idx == 0 || idx == (instance_variables.size -1)
    end
    result
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, attributes)
      UPDATE

      SET

      WHERE

    SQL
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, attributes.shift(1))
      INSERT INTO
          #{Class.self} (#{generate_names})
      VALUES
        #{generate_question_marks}
    SQL
  end

  def attributes
    val = []
    i_var = instance_variables
    i_var.each do |inst|
      val << send(inst[1..-1].to_s)
    end
    val
  end

end
