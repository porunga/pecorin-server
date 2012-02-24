module C2dmAccess

def self.c2dm_post_message(registration_id, token, message)
  require 'net/http'
  require 'uri'

  success_flag = false;
  url = URI.parse("https://android.apis.google.com/c2dm/send")
  
  a = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  random = Array.new(16){a[rand(a.size)]}.join
  
  message_data = message.map{|k, v| "&data.#{k}=#{v}"}.reduce{|k, v| k + v}
  data = "registration_id=#{registration_id}&collapse_key=#{random}#{message_data}"
  
  headers = { "Content-Type" => "application/x-www-form-urlencoded",
    "Authorization" => "GoogleLogin auth=#{token}" }
  
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
  res = http.post(url.path, data, headers)
  
  if res.code == "200"
    p "c2dm_message_Success!!!"
    success_flag = true
  else
    p "False"
    end
  
  return success_flag
  
end

def self.get_client_login
  require 'net/https'
  require 'uri'
  
  auth_hash = Hash.new
  url = URI.parse("https://www.google.com/accounts/ClientLogin")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  #    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
  https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  https.verify_depth = 5
    
  req = Net::HTTP::Post.new(url.path)
  req.set_form_data({
                      :accountType => 'HOSTED_OR_GOOGLE',
                      :Email => 'developer@example.com',
                      :Passwd => '********',
                      :service => 'ac2dm',
                        :source => 'com.porunga.pecorin'
                    })
  
  https.start do
    res = https.request(req)
    if res.code == "200"
      res.body.split("\n").each do |data|
        key,value = data.split("=")
        auth_hash[key] = value
        end
    end
  end
  
  auth_hash['Auth']
end

end
