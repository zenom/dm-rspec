module DataMapperMatchers
  
  class HasValidation
    
    def initialize(name, *macro_info)
      @name    = name
      @options = macro_info
      
      @validators = {
        :validates_presence_of        => "PresenceValidator",
        :validates_absence_of         => "AbsenceValidator",
        :validates_acceptence_of      => "AcceptanceValidator",
        #:validates_with_block         => "ValidatesWithBlock",
        :validates_confirmation_of    => "ConfirmationValidator",
        :validates_format_of          => "FormatValidator",
        :validates_length_of          => "LengthValidator",
        :validates_with_method        => "MethodValidator",
        :validates_numericality_of    => "NumericalityValidator",
        :validates_primitive_type_of  => "PrimitiveTypeValidator",
        :validates_uniqueness_of      => "UniquenessValidator",
        :validates_within             => "WithinValidator"
      }
      
    end
    
    # args<Model>: Category
    def matches?(model)
      validation_type, options = @options
      
      #pp @validators[validation_type]
      validation_class = DataMapper::Validations.const_get("#{@validators[validation_type]}") rescue RSpec::Expectations.fail_with("#{validation_type} is not provided.")
      validation = model.validators.context(model.repository.name).detect do |valid|
        valid.field_name == @name and validation_class == valid.class
      end
      
      options ||= {}
      
      case
        
      when @name.nil? || validation_type.nil?
        RSpec::Expectations.fail_with("validation type must be specified (ex: :validates_presence_of)")
      when validation.nil? 
        RSpec::Expectations.fail_with("expected #{@model} to have validation on #{@name} of type #{validation_type}")
      else
        
        options.each do |key,value|
          (validation.options.include? key.to_sym && validation.options[key.to_sym] == value) ? "" : 
            RSpec::Expectations.fail_with("expected #{validation_type} to have option of: #{key} with value of #{value}")
        end
        true
      end
      
    end

    def description
      "has validation"
    end
    
    def failure_message
      "validation failed"
    end
    
    def negative_failure_message
      "validation failed 2"
    end
    
  end

  def has_validation(name, *macro_info)
    HasValidation.new(name, *macro_info)
  end

end