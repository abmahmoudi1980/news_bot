class CreateNews < ActiveRecord::Migration[8.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :summary
      t.string :link
      t.string :translated_title
      t.text :translated_summary

      t.timestamps
    end
  end
end
