# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :consignments, :member =>{:add => :get, :save => :put}
  admin.resources :consignors, :member => {:consignments => :get}
end

map.remove_consignment_admin_consignors 'admin/consignors/consignment/remove/:product_id', :controller => 'admin/consignors', :action => 'remove_consignment'
map.remove_consignment_admin_products 'admin/consignments/remove/:product_id', :controller => 'admin/consignments', :action => 'remove_consignment'
map.consignment_commissions_admin_reports 'admin/reports/consignment_commissions', :controller => 'admin/reports', :action => 'consignment_commissions'