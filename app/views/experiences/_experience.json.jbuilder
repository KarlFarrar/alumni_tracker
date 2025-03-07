
json.extract! experience, :id, :title, :experience_type, :created_at, :updated_at
json.url experience_url(experience, format: :json)
