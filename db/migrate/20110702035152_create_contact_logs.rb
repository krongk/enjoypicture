class CreateContactLogs < ActiveRecord::Migration
  def self.up
    create_table :contact_logs do |t|
      t.string :msg

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_logs
  end
end
