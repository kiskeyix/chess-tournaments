json.array!(@players) do |player|
  json.extract! player, :id, :user_id, :name, :nationality, :gender, :image
  json.url player_url(player, format: :json)
end
