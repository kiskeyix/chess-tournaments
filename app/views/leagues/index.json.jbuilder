json.array!(@leagues) do |league|
  json.extract! league, :id, :name, :image, :description
  json.url league_url(league, format: :json)
end
