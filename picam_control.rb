require 'sinatra'
require 'byebug'

BASE_DIR = "#{ENV['HOME']}/picam"

get '/' do
  @running = File.exist?("#{BASE_DIR}/hooks/start_record")
  if @running
    @action = "stop"
  else    
    @action = "start"
  end

  erb :index
end

get '/start' do 
  `touch #{BASE_DIR}/hooks/start_record`
  redirect "/"
end

get '/stop' do
  `touch #{BASE_DIR}/hooks/stop_record`
  redirect "/"
end

