class Router
  def initialize
    @routes = {}
  end

  def match(route)
    # Update will merge hashes
    # So @routes is a hash and the passed route is a hash
    @routes.update route
  end

  # & will convert the incoming block into a proc
  def routes(&the_proc)
    # instance_eval wil run the passed proc in the context of a class
    # because it takes a block it will convert the incoming proc back into a block
    instance_eval(&the_proc)
    p @routes
  end
end

Router.new.instance_eval { p @routes }

Router.new.routes do
  match '/users' => 'users#index'
  match '/login' => 'sessions#new'
end
