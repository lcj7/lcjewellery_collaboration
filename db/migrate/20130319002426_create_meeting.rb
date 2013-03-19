class CreateMeeting < ActiveRecord::Migration
  def up
    create_table :meetings do |t|
      t.timestamps
      t.text :session_ident
      t.string :name
      t.integer :max_size
      t.integer :current_size
    end
  end

  def down
    drop_table :meetings
  end
end
