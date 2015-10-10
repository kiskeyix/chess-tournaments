json.array!(@games) do |game|
  json.extract! game, :id, :event, :name, :date, :timecontrol, :while_elo, :black_elo, :site, :result, :fen, :pgn, :division_id
  json.url game_url(game, format: :json)
end
