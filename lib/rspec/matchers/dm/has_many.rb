module DataMapperMatchers
  class HasMany
    def initialize(name)
      @name    = name
    end
    
    # args<Model>: Category
    def matches?(model)
      @model = model
      relationship = @model.relationships[@name]
      return false unless relationship
      valid_hasmany = @model && relationship.max >= Infinity
      
      valid_hasmany ? true : RSpec::Expectations.fail_with("#{@name} is not a has_many relation.")
      
    end

    def description
      "has many"
    end
    
    def failure_message
      "has_many relationship #{@name} does not exist for #{@model}"
    end
    
    def negative_failure_message
      "has_many relationship #{@name} exists, but was not expected"
    end
    
  end

  def has_many(name)
    HasMany.new(name)
  end

end