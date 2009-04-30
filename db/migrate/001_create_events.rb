class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :name,         :string
      t.column :summary,      :string, :length => 140
      t.column :description,  :text
      
      t.column :location,     :string
      t.column :sponsor,      :string
      t.column :email,        :string
      t.column :phone,        :string
      t.column :url,          :string
      
      t.column :start_date,   :datetime
      
      t.column :category_id,  :integer
      
      t.column :approved,     :boolean, :default => false, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
