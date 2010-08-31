module DataMapperMatchers
  class HasOne
    def initialize(name)
      @name    = name
    end
    
    # args<Model>: Category
    def matches?(model)
      @model = model
      relationship = @model.relationships[@name]
      return false unless relationship
      valid_hasmany = @model && relationship.max == 1
      
      valid_hasmany ? true : RSpec::Expectations.fail_with("#{@name} is not a has_one relation.")
      
    end

    def description
      "has one"
    end
    
    def failure_message
      "has_one relationship #{@name} does not exist for #{@model}"
    end
    
    def negative_failure_message
      "has_one relationship #{@name} exists, but was not expected"
    end
    
  end

  def has_one(name)
    HasOne.new(name)
  end

end