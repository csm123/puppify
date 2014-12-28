class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
