# Start with: shotgun
# Under Windows: rackup  (CTRL+C and restart on each change)

# patterns/config.ru
# class App
#   def call(env)
#     # Return the response
#     [
#       200,
#       { 'content-type' => 'text/plain' },
#       [env['PATH_INFO']]
#     ]
#   end
# end

# run App.new

# You can also use a proc as a rack application

# my_proc = lambda do
#   [
#     200,
#     { 'content-type' => 'text/plain' },
#     [env['PATH_INFO']]
#   ]
# end
#
# my_proc.call

# Run being the rack method

# run -> (env) do
#   method = env['REQUEST_METHOD']
#   path = env['PATH_INFO']
#
#   if block = Routes[method][path]
#     body = block.call
#     [200, {}, [body]]
#   else
#     [404, {}, ['not found']]
#   end
# end
#
# Routes = {
#   'GET' => {
#     # 'path' => block
#   }
# }.freeze
#
# def get(path, &block)
#   Routes['GET'][path] = block
# end
#
# get '/' do
#   'awesome'
# end
#
# get '/hello' do
#   'hey man!'
# end

require ::File.expand_path('../lib/boot', __FILE__)
require 'application'
run Application.new
