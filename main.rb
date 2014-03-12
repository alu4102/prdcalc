require 'sinatra'
require 'slim'
require 'sass'
require 'v8'                #motor de google para javascript
require 'coffee-script'

before do                   #ejemplo de filtro en sinatra. Se ejecuta antes de cada get (antes de cada ruta)
  set_title
end

#recibe una lista de argumentos y devuelve una cadena con todos los links

helpers do                                  #se utiliza para especificar los metodos que queramos que esten disponibles en una ruta
  def css(*stylesheets)                     #pasamos una lista de argumentos
    stylesheets.map do |stylesheet|   
      %Q{                                   #una cadena de doble comillas
        <link href="/#{stylesheet}.css" 
              media="screen, projection" 
              rel="stylesheet" 
        />
      }
    end.join
  end
  
  def current?(path='/')
    (request.path==path || request.path==path+'/') ? "current" : nil
  end
  
  def set_title
    @title ||= "Predictive Recursive Descent Parser"
  end
end

get('/styles.css'){ scss :styles }
get('/javascripts/main.js'){ coffee :main }

get '/' do
  slim :home
end

get '/grammar' do
  slim :grammar
end

not_found do
  slim :not_found
end

