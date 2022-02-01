Rails.application.routes.draw do
  root :to => "homepage#index"
  namespace "api", defaults: {format: :json} do
    get '/forecasts', to: "forecasts#index"
  end
  get '/forecasts', to: "forecasts#index"
end
