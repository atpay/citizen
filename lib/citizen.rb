module Citizen
  class Base
    include ActiveModel::MassAssignmentSecurity
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModel::Serialization

    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    extend ActiveModel::AttributeMethods
    extend ActiveModel::Callbacks
    extend ActiveModel::Naming

    define_model_callbacks :update, :save

    attr_accessor :attributes

    class << self
      def create(attributes={})
        new(attributes).tap(&:save) 
      end
    end

    def initialize(attributes={})
      self.attributes = attributes
    end

    def attributes=(attributes)
      (@attributes = HashWithIndifferentAccess.new(attributes)).each do |k,v|
        unless self.class.active_authorizer[:default].deny?(k.to_s)
          self.send("#{k}=", v)
        end 
      end
    end
 
    def update(attributes={})
      run_callbacks(:update) {
        self.attributes = attributes
      }
    end
      
    def save
      run_callbacks(:save) {
        valid?
      }
    end

    def persisted?
      false
    end
  end
end
