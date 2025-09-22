class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :original_url, null: false
      t.string :slug, null: false
      t.integer :visits_count, null: false, default: 0
      t.timestamps
    end

    add_index :short_urls, :slug, unique: true
  end
end
