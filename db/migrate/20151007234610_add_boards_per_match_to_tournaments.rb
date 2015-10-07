class AddBoardsPerMatchToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :boards_per_match, :integer, default: 4
  end
end
