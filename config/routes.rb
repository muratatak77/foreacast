Rails.application.routes.draw do
  namespace "api", defaults: {format: :json} do
    get '/forecasts', to: "forecasts#index"
  end
  get '/forecasts', to: "forecasts#index"
end
