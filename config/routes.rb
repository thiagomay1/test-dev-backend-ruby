Rails.application.routes.draw do
  Healthcheck.routes(self)
  namespace 'api' do
    namespace 'v1' do
      resources :order
    end
  end
end
