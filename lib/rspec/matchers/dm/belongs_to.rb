module DataMapperMatchers
  class BelongsTo
    # args<Symbol>: :products
    def initialize(name)
      @name = name
    end
    
    # args<Model>: Category
    def matches?(model)
      @model = model
      
      # see if the model even exists, if not return an error
      # just in case someone belongs_to a non-existant class.
      DataMapper.const_get(@name.to_s.capitalize) 
        rescue RSpec::Expectations.fail_with("#{@name.to_s.capitalize} model does not exist. (Reference: #{@model})")

      relationship = @model.relationships[@name]
      return false unless relationship
      relationship.name == @name && relationship.child_model == @model
    end
    
    def description
      "belongs to"
    end
    
    def failure_message
      belonging = @model.relationships.select { |name, relationship| relationship.name == @name && relationship.child_model == @model }
      belonging.map! { |array| array.first }
      belonging.empty? ? "expected #{@name} relation to belong to #{@model}" : ""
    end
    
    def negative_failure_message
      "expected #{@model} to not have relation of #{@name}, exists"
    end
  end

  def belongs_to(name)
    BelongsTo.new(name)
  end
end