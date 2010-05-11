# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :consignments
  admin.resources :products do |product|
    product.resources :consignments, :member => {:select => :post, :remove => :post}, :collection => {:available => :post, :selected => :get}
  end
  admin.resources :orders do |order|
    order.resources :consignments, :collection => {:line_items => :get}
  end
end