class CreatePresentation < ActiveRecord::Migration
  def up
    create_table :presentations do |t|
      t.references :meeting
      t.string :viewer_url
      t.string :share_code
      t.text :applet_html
      t.string :participant_id

      t.timestamps
    end
  end

  def down
    drop_table :presentations
  end
end
