class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.references :page
      t.string :global_path
      t.string :shortcut_path
      t.string :title
      t.string :summary
      t.integer :width
      t.integer :height

      t.timestamps
    end

  end

  def self.down
    drop_table :pictures
  end
end
