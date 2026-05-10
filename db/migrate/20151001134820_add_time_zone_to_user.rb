class AddTimeZoneToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :time_zone, :string, default: 'Eastern Time (US & Canada)'
  end
end
