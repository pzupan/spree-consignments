# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :consignments, :member =>{:add => :get, :save => :put}
  admin.resources :consignors, :member => {:consignments => :get}
end

map.remove_consignment_admin_consignor 'admin/consignor/consignment/remove/:product_id', :controller => 'consignor', :action => 'remove_consignment'
map.remove_consignment_admin_product 'admin/consignments/remove/:product_id', :controller => 'consignment', :action => 'remove_consignment'