json.extract! student, :id, :uin, :classification, :major, :resumelink, :email, :phone, :biography, :created_at, :updated_at
json.url student_url(student, format: :json)
