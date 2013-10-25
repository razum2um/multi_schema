module MultiSchema
  module Behaviors
    @@disable_message = false
    @@default_search_path = '"$user",public'

    def disable_message=(val)
      @@disable_message = val
    end

    def disable_message
      @@disable_message
    end

    def default_search_path=(val)
      @@default_search_path = val
    end

    def default_search_path
      @@default_search_path
    end

    def with_in_schemas(options = nil)
      options = unify_type(options, Hash) { |items| {:only => items} }
      options[:only] = unify_type(options[:only], Array) { |item| item.nil? ? all_schemas : [item] }.map { |item| item.to_s }
      options[:except] =unify_type(options[:except], Array) { |item| item.nil? ? [] : [item] }.map { |item| item.to_s }

      options[:only] = unify_array_item_type(options[:only], String) { |symbol| symbol.to_s }
      options[:except] = unify_array_item_type(options[:except], String) { |symbol| symbol.to_s }

      schema_list = options[:only].select { |schema| options[:except].exclude? schema }

      schema_list.each do |schema|
        set_schema_path schema
        yield schema
      end
      reset_schema_path
    end

    def all_schemas
      ActiveRecord::Base.connection.select_values <<-END
      SELECT *
      FROM pg_namespace
      WHERE
        nspname NOT IN ('information_schema') AND
        nspname NOT LIKE 'pg%'
      END
    end

    def current_schema
      ActiveRecord::Base.connection.current_schema
    end

    def reset_schema_path
      puts "--- Restore Schema to #{@@default_search_path}" unless disable_message
      ActiveRecord::Base.connection.schema_search_path = @@default_search_path
    end

    def schema_path
      ActiveRecord::Base.connection.schema_search_path
    end

    def set_schema_path(schema)
      puts "--- Select Schema: #{schema} " unless disable_message
      ActiveRecord::Base.connection.schema_search_path = schema
    end

    def push_schema_to_path(schema)
      new_path = "#{schema}, #{schema_path}"
      set_schema_path(new_path)
    end

    def pop_schema_from_path
      new_path = schema_path.sub(/\w,/, '')
      set_schema_path(new_path)
    end

    private

    def unify_type(input, type)
      if input.is_a?(type)
        input
      else
        yield input
      end
    end

    def unify_array_item_type(input, type, &block)
      input.map do |item|
        unify_type item, type, &block
      end
    end
  end
end
