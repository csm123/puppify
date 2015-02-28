class AddCategorySubscriptions < ActiveRecord::Migration
  def change
    create_table :category_subscriptions do |t|
      t.references :category, index: true
      t.references :user
      t.timestamps
    end
  end
end
