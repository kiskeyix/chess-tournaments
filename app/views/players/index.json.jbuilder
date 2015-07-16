json.array!(@players) do |player|
  #json.extract! player, :id, :user_id, :name, :nationality, :gender, :image
  json.extract! player, :id, :name
  json.set! :label, player.name
  json.set! :value, player.id
  json.url player_url(player, format: :json)
end
