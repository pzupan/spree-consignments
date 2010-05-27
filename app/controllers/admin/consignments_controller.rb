class Admin::ConsignmentsController < Admin::BaseController
  resource_controller

  def index
    @products = Product.paginate(:all,
      :conditions => 'consignment_id IS NOT NULL', 
      :include => :consignment,
      :order => 'consignment_id, name',
      :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def add
    @product = Product.find(params[:id])
    if @product.consignment_id.nil?
      @consignment = Consignment.new
    else
      @consignment = Consignment.find(@product.consignment_id)
    end
    @consignors = Consignor.find(:all,
      :select => "id, concat(id, ' - ', last_name, ', ', first_name) as name",
      :order => 'last_name, first_name')
    respond_to do |format|
      format.html # add.html.erb
    end
  end
  
  def save
    if !params[:consignment][:consignor_id].empty?
      consignment = Consignment.find_by_id(params[:consignment][:id])
      if consignment.nil? 
        consignment = Consignment.create(params[:consignment])
      else
        consignment.update_attributes(params[:consignment])
      end
      if Product.update(params[:product_id], :consignment_id => consignment.id)
        flash[:notice] = I18n.t("notice_messages.product_consignment_saved")
      else
        flash[:error] = I18n.t("notice_messages.product_consignment_not_saved")        
      end
    else
      flash[:error] = I18n.t("notice_messages.no_consignor_selected")
    end
    respond_to do |format|
      format.html {redirect_to edit_admin_product_url(params[:product_id]) }
    end
  end

  def remove_consignment
    product = Product.find(params[:product_id])
    consignment_id = product.consignment_id
    Product.update(product.id, :consignment_id => nil)
    if Product.find_by_consignment_id(consignment_id) == nil
      Consignment.destroy(consignment_id)
    end
  end
   
end