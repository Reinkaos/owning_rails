require 'filtering'

module ActionController
  # This class is used so that we can override methods in modules
  # It does the bare minimum
  class Metal
    attr_accessor :request, :response

    # This takes a string and calls the method with that name on the instantiated class
    def process(action_name)
      send action_name
    end
  end

  # All the modules are included here
  class Base < Metal
    include Filtering
  end
end
