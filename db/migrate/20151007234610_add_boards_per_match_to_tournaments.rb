class AddBoardsPerMatchToTournaments < ActiveRecord::Migration[4.2]
  def change
    add_column :tournaments, :boards_per_match, :integer, default: 4
  end
end
