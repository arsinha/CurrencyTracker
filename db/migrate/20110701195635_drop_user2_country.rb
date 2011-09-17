class DropUser2Country < ActiveRecord::Migration
  def self.up
	  drop_table :user_2_country
  end

  def self.down
	  create_table "user_2_country", :id => false, :force => true do |t|
	    t.integer  "user_id",      :null => false
	    t.string   "country_code", :null => false
	    t.timestamps
	  end

	  add_index "user_2_country", ["user_id", "country_code"], :unique => true
  end
end
