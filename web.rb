require 'rubygems'
require 'sinatra'
get '/' do
    "Hello, World!!!"
end
get '/:id' do
    @id = params[:id]
    @items = ['red', 'green', 'yellow']
    haml :index
end