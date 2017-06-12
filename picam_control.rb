require 'sinatra'
require 'sinatra/flash'

enable :sessions

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

get '/restart_nginx' do
  `sudo service nginx restart`
  flash[:info] = "Nginx restarted"
  redirect "/"
end

get '/start_picam' do
  width = params[:width].to_i
  height = params[:height].to_i
  fps=params[:fps].to_i

  if File.exist?("#{ENV['HOME']}/picam")
    `cd #{ENV['HOME']}/picam;./picam --tcpout tcp://127.0.0.1:8181 --alsadev hw:1,0 -w #{width} -h #{height} --fps #{fps}`
    flash[:info] = "PICAM started #{width}x#{height}@#{fps}"
  else
    flash[:warning] = "PICAM doesn't exist!"
  end
  redirect "/"
end

get '/start' do 
  flash[:info] = "Recording started"
  `touch #{BASE_DIR}/start_record`
  redirect "/"
end

get '/stop' do
  flash[:info] = "Recording stopped"
  `touch #{BASE_DIR}/stop_record`
  redirect "/"
end

