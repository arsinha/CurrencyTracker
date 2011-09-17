class User < ActiveRecord::Base
	has_many :visits
	has_many :countries, :through => :visits, :uniq => true
  after_validation :hash_password

	def currencies
		self.countries.map{|country| country.currencies}.flatten
  end

  def hash_password
   if self.password_changed?
     self.password = Digest::MD5.hexdigest(self.password)
   end
  end

end
