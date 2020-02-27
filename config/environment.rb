# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
class FirebaseConfigInvalidError< StandardError; end
class DefaultBucketCannotBeFetchedError< StandardError; end

Rails.application.initialize!
