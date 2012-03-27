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

      def serializable?(validator)
        !(validator.options[:in] && validator.options[:in].is_a?(Proc))
      end

      def validator_hash(validator)
        validator_hash = {}
        options = %w(accept allow_blank allow_nil in on message)
        options.each do |option|
          if validator.options.has_key?(option.to_sym)
            validator_hash[option] = validator.options[option.to_sym]
          end
        end
        validator_hash = true if validator_hash.empty?
        validator_hash
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ValidationsJson)
