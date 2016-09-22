class HomeController < ApplicationController
  before_action :header
  after_action :footer

  def index
    response.write 'hi from HomeController'
  end

  def header
    response.write '<h1>My App</h1>'
  end

  def footer
    response.write '<h1>Here is a footer</h1>'
  end
end
