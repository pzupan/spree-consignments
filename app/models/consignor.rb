class Consignor < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  has_many :consignments, :dependent => :destroy
end
