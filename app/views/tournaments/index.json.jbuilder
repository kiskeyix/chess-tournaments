json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :image, :description
  json.url tournament_url(tournament, format: :json)
end
