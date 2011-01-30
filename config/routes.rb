Decade::Application.routes.draw do
  
  scope "/knox" do
    resource :gate, :controller => 'user_sessions', :path_names => { :new => 'open' } do
      get 'logout', :action => 'destroy'
    end
    resources :images
  end
  
  
  
  match ':y/:m/:d/photo.small', :controller => 'public', :action => "small_photo", :y => /\d{4}/, :m => /\d{1,2}/, :d => /\d{1,2}/
  match ':y/:m/:d/photo', :controller => 'public', :action => "photo", :y => /\d{4}/, :m => /\d{1,2}/, :d => /\d{1,2}/
  match ':y/:m/:d', :controller => 'public', :action => "view", :y => /\d{4}/, :m => /\d{1,2}/, :d => /\d{1,2}/
  match ':y/:m', :controller => 'public', :action => "month", :y => /\d{4}/, :m => /\d{1,2}/
  match ':y', :controller => 'public', :action => "year", :y => /\d{4}/
  
  match 'archive', :controller => 'public', :action => 'archive'
  match 'about', :controller => 'public', :action => 'about'
  match 'syndicate', :controller => 'public', :action => 'syndicate'
  
  root :to => 'public#index'

end
