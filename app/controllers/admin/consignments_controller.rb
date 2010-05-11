class Admin::ConsignmentsController < Admin::BaseController
  resource_controller
  belongs_to :product
  before_filter :load_data, :only => [:selected, :available, :remove, :new, :edit, :select]

  def line_items
    @order = Order.find_by_number(params[:order_id])
  end
  
  def selected
    @consignment = @product.consignment
  end
  
  def available
    if params[:q].blank?
      @available_consignments = []
    else
      @available_consignments = Consignment.find(:all, :conditions => ['lower(name) LIKE "%#{params[:q].downcase}%"'])
    end
    @available_consignments.delete_if { |consignment| @product.consignment == consignment }
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
 
  end
  
  def remove
    Consignment.destroy[@product.consignment.id]
    @consignment = @product.consignment.reload
    render :layout => false
  end
  
  def select
    @product.consignment = Consignment.find_by_param!(params[:id])
    @product.save
    @consignment = @product.consignment
    render :layout => false
  end


  update.response do |wants|
    wants.html { redirect_to collection_url }
  end
 
  update.after do
    Rails.cache.delete('consignments')
  end
 
  create.response do |wants|
    wants.html { redirect_to collection_url }
  end
 
  create.after do
    Rails.cache.delete('consignments')
  end
  
  private

  def load_data
    default_country = Country.find Spree::Config[:default_country_id]
    @states = default_country.states.sort
    @product = Product.find_by_permalink(params[:product_id])
  end
 
end