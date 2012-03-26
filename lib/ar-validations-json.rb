module ActiveRecord
  module ValidationsJson
    def self.included(mod)
      mod.extend(ClassMethods)
      super
    end

    module ClassMethods
      def validations_json
        json_hash = Hash.new { |h,k| h[k] = {} }
        validators.each do |validator|
          case validator
          when ActiveModel::Validations::AcceptanceValidator
            validator.attributes.each do |attr|
              validator_hash = {}
              if msg = validator.options[:message]
                validator_hash['message'] = msg
              end
              validator_hash = true if validator_hash.empty?
              json_hash[attr.to_s]['acceptance'] = validator_hash
            end
          end
        end
        json_hash.to_json
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ValidationsJson)
