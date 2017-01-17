Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :add_to_redis, to: "messages#add_to_redis"
    end
  end
end
