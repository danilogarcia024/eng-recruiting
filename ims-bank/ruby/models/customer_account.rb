class CustomerAccount < ActiveRecord::Base
	belongs_to :customer
	belongs_to :account
end  