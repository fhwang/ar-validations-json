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
            json_hash[validator.attributes.first.to_s] =
              {'acceptance' => true}
          end
        end
        json_hash.to_json
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ValidationsJson)
