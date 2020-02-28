# devitary
A simple rails application with an API and a simple web interface to upload & host static files (Images, Fonts) or any other files with Google Firebase for free (refer [limits](https://firebase.google.com/docs/firestore/quotas)).
## Deploying your own
1. Create a firebase project - [Firebase Console](https://console.firebase.google.com/).
2. Create a default storage bucket
	* Click Develop > Storage > Get Started > Next > Choose Location > Done
3. Download the credentials json file with private key from firebase console.
	* Click Settings Icon > Project Settings > Service Accounts > Generate new private key > Generate key
4. Clone this repository
	
	``` 
	git clone https://github.com/owaiswiz/devitary.git
	```
5. Set the environment variable ```STORAGE_CREDENTIALS``` with the content of the downloaded json file
6. Run the server using ```rails s``` or deploy how you would deploy any other rails app

# Using the API
Create a post request to ``` /upload``` with the file in the multipart form data body
### Example
```ruby
response = HTTParty.post(
	'http://YOURHOSTEDIPORURL/upload', 
	body: {
		file: File.open("/home/owaiswiz/Downloads/SashaSloan.png")
	}
)
json = JSON.parse(response.body)
puts json["url"]  # => "https://storage.googleapis.com/devitary-image-host.appspot.com/15828387941719051810-c.png" 
```
