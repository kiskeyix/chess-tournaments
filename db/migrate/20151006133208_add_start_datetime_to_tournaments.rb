class AddStartDatetimeToTournaments < ActiveRecord::Migration[4.2]
  def change
    add_column :tournaments, :start_date, :datetime
    add_column :tournaments, :end_date, :datetime
  end
end
