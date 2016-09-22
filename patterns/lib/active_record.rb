require 'connection_adapter'

module ActiveRecord
  # patterns/lib/active_record.rb
  class Base
    CONNECTION = SqliteAdapter.new

    def initialize(attributes = {})
      @attributes = attributes
    end

    # Wheneer a method is called on an instance that is missing
    # This method is called
    # This is allowing us to fallback to a column that reprosents the attribute name
    # This isnt the most effecient way of doing it
    def method_missing(name, *args)
      # We use self.class which is the same as Base.table_name
      # You cannot just do class as it's a reserved keyword
      columns = CONNECTION.columns(self.class.table_name)

      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(id)
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
    end

    def self.all
      find_by_sql("SELECT * FROM #{table_name}")
    end

    def self.find_by_sql(sql)
      CONNECTION.execute(sql).map { |attribute| new(attribute) }
    end

    # This downcases and pluralizes a model name
    # In a very simple way
    # To create a table name
    # This is inside ActiveSupport::Inflector
    # But its much more complex :P
    def self.table_name
      name.downcase + 's'
    end
  end
end
