require 'action_controller'
require 'application_controller'
require 'active_record'
require 'router'
require 'config/routes'

# patterns/lib/application.rb
class Application
  def call(env)
    # This is the same thing as providing the array

    # This is basically how Rails handles the incoming request and responds with the action
    request = Rack::Request.new(env)
    response = Rack::Response.new

    controller_name, action_name = route(request.path_info)
    # ['home', 'index']

    controller_class = load_controller_class(controller_name)
    controller = controller_class.new
    controller.request = request
    controller.response = response
    controller.process action_name # calls the action

    response.finish
  end

  def route(path)
    # This looks like it's destructirng the content?
    # It has since been replaced with Routes.rb
    # _, controller_name, action_name = path.split('/')
    # [controller_name || 'home', action_name || 'index']
    Routes.recognize(path)
  end

  def load_controller_class(name)
    # Don't require in a method in production as its not threadsafe
    require "#{name}_controller" # this is the same as require home_controller
    # This is creating the constant name for the controller class
    Object.const_get name.capitalize + 'Controller'
  end
end
