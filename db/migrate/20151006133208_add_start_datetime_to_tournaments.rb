class AddStartDatetimeToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :start_date, :datetime
    add_column :tournaments, :end_date, :datetime
  end
end
