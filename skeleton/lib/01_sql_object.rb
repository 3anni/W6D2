require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

def snake_case(str)
  res = ""

  (0...str.length).each do |i|
    char = str[i]
    if i == 0
      res += char.downcase
    elsif char == char.upcase
      res += "_" + char.downcase
    else
      res += char
    end
  end

  res += 's'
  res
end

class SQLObject


  def self.columns
    @res ||= DBConnection.execute2(<<-SQL)
      SELECT *
      FROM #{snake_case("#{self}")}
    SQL

    @res[0].map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}".to_sym) do
        # instance_variable_get("@#{col}")
        @attributes[col]
      end

      define_method("#{col}=".to_sym) do |values|
        instance_variable_set("@#{col}", value)
        @attributes[col] = 0
        values.each do |value|
          @attributes[col] << value
        end
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || snake_case("#{self}")
  end

  def self.all
    # ...


  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end



end
