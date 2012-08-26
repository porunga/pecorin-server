module GcmAccess
  require 'net/http'
  require 'uri'
  require 'json'

  API_KEY = ""

  def self.gcm_post_message(registration_ids, data={})
    
    url = URI.parse("https://android.googleapis.com/gcm/send")

    message_data = {}
    message_data["registration_ids"] = registration_ids
    message_data["data"] = data
    
    headers = { "Content-Type" => "application/json", "Authorization" => "key=" + API_KEY }
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    res = http.post(url.path, message_data.to_json, headers)

    if res.code == "200"
      res_message = "GCM Post Message Success."
      return true, res_message
    else
      res_message "GCM Post Message Failed."
    end
    
    return false, res_message 

  end

end
