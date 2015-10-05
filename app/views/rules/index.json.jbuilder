json.array!(@rules) do |rule|
  json.extract! rule, :id, :name, :summary, :body
  json.url rule_url(rule, format: :json)
end
