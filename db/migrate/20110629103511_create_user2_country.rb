class CreateUser2Country < ActiveRecord::Migration
  def self.up
	  create_table(:user_2_country, {:id=>false}) do |t|
		  t.integer :user_id, :null => false
		  t.string :country_code, :null => false

		  t.timestamps
	  end

	  add_index(:user_2_country, [:user_id, :country_code], :unique => true)
  end

  def self.down
	  drop_table :user_2_country
  end
end
