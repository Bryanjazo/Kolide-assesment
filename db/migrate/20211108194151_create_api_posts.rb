class CreateApiPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :api_posts do |t|
      t.string :tags
      t.string :sortBy
      t.string :direction
      t.timestamps
    end
  end
end
