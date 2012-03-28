module ActiveRecord
  module ValidationsJson
    def self.included(mod)
      mod.extend(ClassMethods)
      super
    end

    module ClassMethods
      def validations_json
        Serializer.new(self).to_json
      end
    end

    class Serializer
      def initialize(ar_class)
        @ar_class = ar_class
      end

      def default_to_skip?(validator, option)
        case validator
        when ActiveModel::Validations::NumericalityValidator
          case option
          when 'allow_nil'
            validator.options[option.to_sym] == false
          when 'only_integer'
            validator.options[option.to_sym] == false
          end
        end
      end

      def serializable?(validator)
        options_that_might_be_procs = {
          :in => nil, :tokenizer => %r|/active_model/validations/length.rb$|,
          :with => nil
        }
        !options_that_might_be_procs.any? { |option, whitelisted_source|
          (opt_value = validator.options[option]) && opt_value.is_a?(Proc) &&
           (whitelisted_source.nil? or
            opt_value.source_location.first !~ whitelisted_source)
        }
      end

      def to_json
        json_hash = Hash.new { |h,k| h[k] = {} }
        @ar_class.validators.each do |validator|
          if serializable?(validator)
            label = validator.class.name.split(/::/).last.
                    underscore.split(/_/).first
            validator.attributes.each do |attr|
              json_hash[attr.to_s][label] = validator_hash(validator)
            end
          end
        end
        json_hash.to_json
      end

      def validator_hash(validator)
        validator_hash = {}
        validator_options_to_try_copying.each do |option|
          if validator.options.has_key?(option.to_sym)
            unless default_to_skip?(validator, option)
              validator_hash[option] = validator.options[option.to_sym]
            end
          end
        end
        validator_hash = true if validator_hash.empty?
        validator_hash
      end

      def validator_options_to_try_copying
        %w(
          accept allow_blank allow_nil case_sensitive greater_than
          greater_than_or_equal_to equal_to even in is less_than
          less_than_or_equal_to maximum message minimum odd on only_integer
          scope too_long too_short with without wrong_length
        )
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ValidationsJson)
