module DataMapperMatchers
  class HasAndBelongsToMany
    # args<Symbol>: :products
    def initialize(name)
      @name = name
    end
    
    # args<Model>: Category
    def matches?(model)
      @model = model
      relationship = @model.relationships[@name]
      return false unless relationship

      relationship.class == DataMapper::Associations::ManyToMany::Relationship && 
                            relationship.parent_model == @model && 
                            relationship.child_model == DataMapper.const_get(@name.to_s.capitalize.singularize)
    end
    
    def description
      "has and belongs to many"
    end
    
    def failure_message
      "has_and_belongs_to_many relationship #{@name} does not exist for #{@model}"
    end
    
    def negative_failure_message
      "has_and_belongs_to_many relationship #{@name} exists, but was not expected"
    end
  end

  def has_and_belongs_to_many(name)
    HasAndBelongsToMany.new(name)
  end
end