module HomeHelper
  def upload_file_to_firebase file_path
    credentials_path = Rails.application.config.firebase_credentials_file_path
    credentials = JSON.parse File.read(credentials_path)
    project_id = credentials["project_id"]

    storage = Google::Cloud::Storage.new(
      credentials: credentials_path,
      project_id: project_id
    )

    bucket = storage.bucket("#{project_id}.appspot.com")
    file = bucket.create_file file_path.to_s, file_path.basename.to_s, acl: :public_read
    return file.url
  end
end
