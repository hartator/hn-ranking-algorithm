Rails.application.routes.draw do
  get '/scored' => 'ranks#scored'
end
