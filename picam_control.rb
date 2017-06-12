require 'sinatra'
require 'byebug'

BASE_DIR = "#{ENV['HOME']}/picam/hooks"

get '/' do
  @running = File.exist?("#{BASE_DIR}/start_record")
  if @running
    @action = "stop"
  else    
    @action = "start"
  end

  erb :index
end

get '/start' do 
  `touch #{BASE_DIR}/start_record`
  redirect "/"
end

get '/stop' do
  `touch #{BASE_DIR}/stop_record`
  redirect "/"
end

