require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    @class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    # p "other table = #{name.to_s}"
    primary = options[:primary_key] || :id
    foreign = options[:foreign_key] || "#{name.downcase}_id".to_sym
    c_name = options[:class_name] || name.to_s.singularize.camelcase

    self.send("#{:primary_key}=", primary)
    self.send("#{:foreign_key}=", foreign)
    self.send("#{:class_name}=", c_name)

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    primary = options[:primary_key] || :id
    foreign = options[:foreign_key] || "#{self_class_name.downcase}_id".to_sym
    c_name = options[:class_name] || name.to_s.singularize.camelcase

    self.send("#{:primary_key}=", primary)
    self.send("#{:foreign_key}=", foreign)
    self.send("#{:class_name}=", c_name)

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method("#{name}") do
      # p "The options = #{options}"

      options
        .model_class
        .where( options.primary_key => self.send("#{options.foreign_key}") )
        .first

    end

  end

  def has_many(name, options = {})
    # ...
    options = HasManyOptions.new(name, self.name, options)
    define_method("#{name}") do

      options
        .model_class
        .where( options.foreign_key => self.send("#{options.primary_key}") )
    end

  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @options ||= {}
  end
end

class SQLObject
  extend Associatable
  # Mixin Associatable here...
end
