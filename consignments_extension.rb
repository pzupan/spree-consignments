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
    
    Admin::ConfigurationsController.class_eval do
      before_filter :add_consignments_link, :only => :index
 
      def add_consignments_link
        @extension_links << {:link => admin_consignments_url, :link_text => t('consignments'), :description => t('consignment_description')}
      end
    end
      
    Admin::NavigationHelper.class_eval do
      def link_to_consignor(resource)
        link_to_with_icon('exclamation', t('consignors'), edit_object_url(resource))
      end
      def link_to_consignment(resource)
        link_to_with_icon('exclamation', t('consignments'), edit_object_url(resource))
      end
    end
    
    Product.class_eval do
      belongs_to :consignment
    end
    
    User.class_eval do 
      has_many :consignors
    end
    
    State.class_eval do
      has_many :consignors
    end

  end
end
