class HomeController < ApplicationController
  def index
  end

  def upload
    file = params[:file]
    file_name = "#{Time.now.to_i}#{rand(9000000000)}-#{file.original_filename}"
    file_path = Rails.root.join("tmp", "storage", file_name)
    File.open(file_path, "wb") {|f| f.write(file.read)}
    #Todo: Upload to firebase
    File.delete(file_path)
  end
end
