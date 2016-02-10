json.array!(@teams) do |team|
  json.extract! team, :id, :name
  json.set! :label, team.name
  json.set! :value, team.id
  json.url team_url(team, format: :json)
end
