# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ConsignmentsExtension < Spree::Extension
  version "0.1"
  description "Adds the ability to set up consignments for products."
  url ""

  # Please use consignment/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    
    Admin::BaseController.class_eval do
      before_filter :add_product_consignment_tab, :add_consignments_tab

      def add_consignments_tab
        @order_admin_tabs << {:name => t('consignments'), :url => "line_items_admin_order_consignments_url"}
      end
      
      def add_product_consignment_tab
        @product_admin_tabs << {:name => t('consignments'), :url => "selected_admin_product_consignments_url"}
      end
    end
    
    Admin::ConfigurationsController.class_eval do
      before_filter :add_consignments_link, :only => :index
 
      def add_consignments_link
        @extension_links << {:link => admin_cosignments_url, :link_text => t('consignments'), :description => t('consignment_description')}
      end
    end
    
    Product.class_eval do
      belongs_to :consignment
    end
    
    State.class_eval do
      has_many :consignments
    end

  end
end
