require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    col = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT 0
    SQL

    @columns = col.flatten.map! {|el| el.to_sym}
  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}") do
        return self.attributes[col]
      end

      define_method("#{col}=") do |val|
        return self.attributes[col] = val
      end

    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
    results = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL

    self.parse_all(results)
  end


  def self.parse_all(results)
    # ...
    results.map do |params|
      self.new(params)
    end

  end

  def self.find(id)
    # ...
    self.all.each do |obj|
      return obj if obj.id == id
    end
    return nil

  end

  def initialize(params = {})
    # ...

    cols = self.class.columns
    params.each do |attr_name, value|
      attr_name_sym = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless cols.include?(attr_name_sym)
      self.send("#{attr_name}=", value)
    end


  end

  def attributes
    # ...
    @attributes ||= {}

  end

  def attribute_values
    # ...
    val = []
    self.class.columns.each do |col|
      val << attributes[col]
    end
    return val
  end

  def insert
    # ...
    cols = self.class.columns.drop(1)
    col_names = cols.join(",")
    question_marks = (["?"] * cols.count).join(",")
    val = attribute_values.drop(1)

    DBConnection.execute(<<-SQL, val)
      INSERT INTO #{self.class.table_name} ( #{col_names} )
      VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    val = attribute_values
    val.push(val.shift)

    cols = self.class.columns.drop(1)
    col_names = cols.join(" = ?, ")
    col_names << " = ?"

    # p val
    # p col_names
    # p self.class.find(2)

    DBConnection.execute(<<-SQL, *val)
      UPDATE #{self.class.table_name}
      SET #{col_names}
      WHERE #{self.class.table_name}.id = ?

    SQL
  end

  def save
    # ...
    if self.id.nil?
      insert
    else
      update
    end

  end
end
