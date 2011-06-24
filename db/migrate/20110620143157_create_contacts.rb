class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :typo, :default => 'wenba'
      t.string :name
      t.string :gender
      t.date :birth
      t.string :wedding
      t.string :address
      t.string :email
      t.string :qq
      t.string :phone
      t.text :content
      t.string :is_processed, :default => 'n'
      t.string :processed_by
      t.text :note
      t.string :is_visiable, :default => 'y'
      t.string :is_destroy, :default => 'n'

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
