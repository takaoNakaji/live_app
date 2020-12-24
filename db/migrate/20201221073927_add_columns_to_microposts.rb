class AddColumnsToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :title, :string
    add_column :microposts, :live_on, :date
    add_column :microposts, :live_from_at, :datetime
    add_column :microposts, :live_to_at, :datetime
    add_column :microposts, :area, :string
    add_column :microposts, :address, :string
    add_column :microposts, :url, :text
    add_column :microposts, :act, :string
    add_column :microposts, :deleted, :boolean, null: false, default: false
  end
end
