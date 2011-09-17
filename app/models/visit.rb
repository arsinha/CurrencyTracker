class Visit < ActiveRecord::Base
	belongs_to :user
	belongs_to :country, :foreign_key => :country_code
end
