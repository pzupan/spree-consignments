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

    Admin::ReportsController.class_eval do

      def index
        reports = Admin::ReportsController.const_get(:AVAILABLE_REPORTS)
        new_line_items = {:consignment_commissions => {:name => "consignment_commissions", :description => "commissions_due_for_consignments"}}
        @reports = reports.update(new_line_items)
      end

      def consignment_commissions
        
        # Issue in Spree with line_items model.  Force the query instead of using named_scopes.
        sql_string = "orders.completed_at IS NOT NULL AND " + 
          "products.consignment_id IS NOT NULL"
        join_string = "INNER JOIN orders ON line_items.order_id = orders.id " +
          "INNER JOIN variants ON line_items.variant_id = variants.id " +
            "INNER JOIN products ON variants.product_id = products.id " +
            "INNER JOIN consignments ON consignments.id = products.consignment_id " +
            "INNER JOIN consignors ON consignments.consignor_id = consignors.id"
        select_string = "line_items.id, line_items.quantity, line_items.price, orders.completed_at, " + 
          "products.name, consignments.id, consignments.commission, consignors.first_name, consignors.last_name"

        @search = LineItem.searchlogic(params[:search])
 
        @line_items = @search.find(:all,
          :select => select_string,
          :conditions => sql_string,
          :joins => join_string,
          :order => 'consignors.last_name, consignors.first_name, products.consignment_id, orders.completed_at')

        @item_total = @line_items.sum { |p| p.quantity * p.price }
        @commission_total = @line_items.sum { |p| (p.quantity * p.price) * (p.commission.to_f / 100)}
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
    
    LineItem.class_eval do
      named_scope :checkout_complete, {:include => :order, :conditions => ["orders.completed_at IS NOT NULL"]}
      named_scope :is_consignment, {:include => :product, :conditions => ["products.consignment_id IS NOT NULL"]}
    end
      
    User.class_eval do 
      has_many :consignors
    end
    
    State.class_eval do
      has_many :consignors
    end

  end
end
