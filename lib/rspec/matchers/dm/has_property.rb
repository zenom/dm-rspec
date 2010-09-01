module DataMapperMatchers
  class HasProperty 

    def initialize(expected, field_type)
      @expected = expected
      @field_type = field_type
    end
    
    # Post.should has_property :title, String, :required => true, :default => ""
    def matches?(model)
      @model = model
      field = @model.properties[@expected.to_sym]
      
      if @field_type.nil?
        RSpec::Expectations.fail_with "you must specify a property type (String, Integer)"
      elsif @expected.nil?
        RSpec::Expectations.fail_with "expected #{model.to_s} to have field #{@expected}"
      elsif @field_type != field.field.class
        RSpec::Expectations.fail_with "expected #{field.field} to have type of #{@field_type.to_s} but has #{field.field.class.to_s}"
      else
        true
      end
    end
    
    def description
      "has property"
    end
        
  end
  
  def has_property(expected, field_type)
    HasProperty.new(expected, field_type)
  end
end