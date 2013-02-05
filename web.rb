require 'rubygems'
require 'sinatra'

get '/:id' do
    @id = params[:id]
    @items = ['red', 'green', 'yellow']
    haml :index
end