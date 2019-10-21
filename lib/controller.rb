require_relative 'gossip'

class ApplicationController < Sinatra::Base

#page index
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
#page affichant le gossip choisi
  get '/gossips/:id' do
    erb :show, locals: {gossips: Gossip.find(params['id'])}
  end

#page affichant la page permettant d'éditer
  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossips: Gossip.all}
  end

#page permettant l'édition
  post '/gossips/:id/edit/' do
      erb :edit, locals: {gossips: Gossip.all}
      Gossip.new(" "," ").update(params['id'], params['comment'])
      redirect '/gossips/:id'
  end

#permet d'aller à la page de création des gossips
  get '/gossips/new/' do
    erb :new_gossip
  end

#permet de créer un gossip
  post '/gossips/new/' do
  mon_gossip = Gossip.new(params["gossip_author"],params["gossip_content"])
  mon_gossip.save
  puts mon_gossip
  redirect '/'
  end

end
