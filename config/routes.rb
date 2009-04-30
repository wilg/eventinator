ActionController::Routing::Routes.draw do |map|
  map.resources :events

  map.root :controller => "events"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
