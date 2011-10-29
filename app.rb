class App < Sinatra::Base
  helpers Sinatra::Partials
  
  configure do
    set :root, File.dirname(__FILE__)
    
    # Configure public directory
    set :public, Proc.new { File.join(root, "public") }
    
    # Configure HAML and SASS
    set :haml, { :format => :html5 }
    set :sass, { :style => :compressed } if ENV['RACK_ENV'] == 'production'
    
    # session storage ? using cookies most likely
    set :session, true
  end

  helpers do
    def link_to text, url=nil
      haml "%a{:href => '#{ url || text }'} #{ text }"
    end

    def link_to_unless_current text, url=nil
      if url == request.path_info
        text
      else
        link_to text, url
      end
    end
    
    def img(name, classes="")
      "<img src='images/#{name}' alt='#{name}' class=>'#{classes}'/>"
    end
    
  end

  # SASS stylesheet
  get "/css/global.css" do
    headers 'Content-Type' => 'text/css; charset=utf-8'
    sass :"css/global"
  end

  get '/' do
    haml :index, :layout => :'layouts/default'
  end

  get '/about' do
    haml :about, :layout => :'layouts/default'
  end

  # left in as example code
  # get '/form' do
  #   %{ <form action="/name" method="post">
  #         <input name="person" type="text">
  #         <input type="submit">
  #      </form> }
  # end
  #
  # post '/name' do
  #   haml "Hello #{ params[:person] }", :layout => :'layouts/default'
  # end
  # 
  # get "/user/:id" do
  #   "You're looking for user with id #{ params[:id] }"
  # end
end

