class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :upload
  def index
  end

  def upload
    begin
      file = params[:file]
      file_name = "#{Time.now.to_i}#{rand(9000000000)}-#{file.original_filename}"
      file_path = Rails.root.join("tmp", file_name)

      File.open(file_path, "wb") {|f| f.write(file.read)}
      uploaded_url = helpers.upload_file_to_firebase file_path
      File.delete(file_path)

      render json: {
        url: uploaded_url
      }, status: 200
    rescue FirebaseConfigInvalidError => e
      puts e.backtrace
      render json: {
        error: "Firebase Config does not exist or is not in a valid format. Make sure proper path is set in config/application.rb"
      }, status: 500
    rescue DefaultBucketCannotBeFetchedError => e
      puts e.backtrace
      render json: {
        error: "Default bucket could not be fetched. Make sure you have created a default storage bucket (read the readme.md) & your account is working & the default bucket is accessible from firebase console"
      }, status: 500
    end
  end
end
