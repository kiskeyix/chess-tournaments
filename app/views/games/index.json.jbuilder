json.array!(@games) do |game|
  json.extract! game, :id, :event, :name, :date, :timecontrol, :white_elo, :black_elo, :site, :result, :fen, :pgn, :division_id, :white_player_id, :black_player_id
  json.url game_url(game, format: :json)
end
