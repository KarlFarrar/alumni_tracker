json.extract! student, :id, :uin, :classification, :major, :resumelink, :email, :phone, :linkedin, :created_at, :updated_at
json.url student_url(student, format: :json)
