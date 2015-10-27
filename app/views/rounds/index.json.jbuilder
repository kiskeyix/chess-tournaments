json.array!(@rounds) do |round|
  json.extract! round, :id, :name, :description, :start_date, :end_date, :tournament_id
  json.url round_url(round, format: :json)
end
