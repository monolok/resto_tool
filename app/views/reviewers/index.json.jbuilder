json.array!(@reviewers) do |reviewer|
  json.extract! reviewer, :id
  json.url reviewer_url(reviewer, format: :json)
end
