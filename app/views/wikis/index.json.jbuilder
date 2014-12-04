json.array!(@wikis) do |wiki|
  json.extract! wiki, :id, :name, :body, :private, :user_id
  json.url wiki_url(wiki, format: :json)
end