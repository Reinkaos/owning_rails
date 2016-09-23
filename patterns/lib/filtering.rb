require 'active_support/concern'
require 'active_support/callbacks'

# patterns/lib/filtering.rb
module Filtering
  # base will be the action controller
  # This allows us to include methods form this module as class methods on the class including it
  # ActiveSupport::Concern does this for you.
  # This is a hook included by Ruby
  # def self.included(base)
  #   base.extend ClassMethods
  # end
  #
  # module ClassMethods
  #   def before_action(method)
  #     before_actions << method
  #   end
  #
  #   def before_actions
  #     @before_actions ||= []
  #   end
  #
  #   def after_action(method)
  #     after_actions << method
  #   end
  #
  #   def after_actions
  #     @after_actions ||= []
  #   end
  # end
  #
  # def process(action_name)
  #   # Once again this is so we can call class level methods on the
  #   # Class that includes this module
  #   # A little confusing because those methods are above,
  #   # But they will be class level methods in the context
  #   # of the class that includes this methiod
  #   self.class.before_actions.each { |method| send method }
  #   super
  #   self.class.after_actions.each { |method| send method }
  # end

  # This is the same as the above
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks

  included do
    define_callbacks :process
  end

  class_methods do
    def before_action(method)
      set_callback :process, :before, method
    end

    def after_action(method)
      set_callback :process, :after, method
    end
  end

  def process(action_name)
    run_callbacks :process do
      super
    end
  end
end
