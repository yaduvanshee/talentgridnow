class AddColumShortUrl < ActiveRecord::Migration[7.2]
  def change
    add_column :short_urls, :restrict_visit_count, :integer
  end
end
