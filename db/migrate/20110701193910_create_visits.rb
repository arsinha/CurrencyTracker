class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :user_id, :null => false
      t.string :country_code, :null => false
      t.date :visit_date

      t.timestamps
    end

	  add_index :visits, [:user_id, :country_code], :unique => true
  end

  def self.down
    drop_table :visits
  end
end
