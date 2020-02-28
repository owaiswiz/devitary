module HomeHelper
  def upload_file_to_firebase file_path
    begin
      credentials = JSON.parse(Rails.application.config.firebase_credentials)

      raise unless credentials

      project_id = credentials["project_id"]

      storage = Google::Cloud::Storage.new(
        credentials: credentials,
        project_id: project_id
      )
    rescue
      raise FirebaseConfigInvalidError
    end


    begin
      bucket = storage.bucket("#{project_id}.appspot.com")
      raise unless bucket
    rescue
      raise DefaultBucketCannotBeFetchedError
    end

    file = bucket.create_file file_path.to_s, file_path.basename.to_s, acl: :public_read
    return file.url
  end
end
