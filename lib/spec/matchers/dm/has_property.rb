module DataMapperMatchers
  class HasProperty 

    def initialize(expected, *macro_info)
      @expected = expected
      @options  = *macro_info
    end
    
    # Post.should has_property :title, String, :required => true, :default => ""
    def matches?(model)
      key_type, options = @options
      @model = model
      field = @model.properties[@expected.to_sym]
      
      if options.nil? || options.empty?
        RSpec::Expectations.fail_with "field options must be specified"
      elsif @expected.nil?
        RSpec::Expectations.fail_with "expected #{model.to_s} to have field #{@expected}"
      elsif key_type != field.field.class
        RSpec::Expectations.fail_with "expected #{field.field} to have type of #{key_type.to_s} but has #{field.field.class.to_s}"
      else
        options_valid = options.all? { |key,value| field.send(key) == value }
        return options_valid ? true :
                               RSpec::Expectations.fail_with("expected model to have options #{options.inspect} on field #{field.field}")
      end
    end
    
    def description
      "has property"
    end
        
  end
  
  def has_property(expected, *options)
    HasProperty.new(expected, *options)
  end
end