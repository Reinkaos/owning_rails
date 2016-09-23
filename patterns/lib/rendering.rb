require 'erb'
# To render an ERB template:
#
#   ERB.new(File.read(erb_file_path)).result(binding)

module Rendering
  def render(action)
    response.write render_to_string(action)
  end

  def render_to_string(action)
    path = template_path(action)
    template = ERB.new(File.read(path))

    # binding encapsulates the current context of execution
    # so all the instance variables, local variables and self
    # So when we do this it evals the template and renders it with context
    template.result(binding)

    # Templates compile the template string to ruby code
    # Then eval it within the context of the variables by using binding.
    # eval(template.src, binding)
  end

  def template_path(action)
    "app/views/#{controller_name}/#{action}.html.erb"
  end

  def layout_path
    'app/views/layouts/application.html.erb'
  end

  def controller_name
    self.class.name[/^(\w+)Controller/, 1].downcase # HomeController => "home"
  end
end
