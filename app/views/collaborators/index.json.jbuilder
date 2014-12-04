json.array!(@collaborators) do |collaborator|
  json.extract! collaborator, :id, :user_id, :wiki_id
  json.url collaborator_url(collaborator, format: :json)
end