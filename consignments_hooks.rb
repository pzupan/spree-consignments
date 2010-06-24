class ConsignmentsHooks < Spree::ThemeSupport::HookListener
   
  # adding new tab to the admin navigation
  insert_after :admin_tabs do
    '<%= tab :consignors %>'
  end

  insert_after :admin_product_sub_tabs do 
    '<%= tab :consignments %>'
  end 
  
  insert_after :admin_product_tabs do
    '<% if url_options_authenticate?(:controller => "admin/consignments") %>' +
        '<li <%= "class=' + "'active'" + '" if current == "Consignment" %>>' + 
           '<%= link_to t("consignment"),  add_admin_consignment_url(@product.id) %></li>'+
    '<% end %>'
  end
  
end
