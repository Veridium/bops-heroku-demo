require 'openssl'
require 'base64'

class ProfileController < ApplicationController

  def profile_status
    puts session[:vid_auth_session_id]

    privkey = OpenSSL::PKey::RSA.new ENV['FRIENDPRIVKEY']
    friendcert = OpenSSL::X509::Certificate.new ENV['FRIENDCERT']

    rc1 = RestClient::Resource.new(
	"https://#{ENV['BOPSSRV']}/websec/rest/enterprise/GetSessionStatus",
	:ssl_client_cert => friendcert,
	:ssl_client_key => privkey,
	:verify_ssl => false)

    data1 = {sessionId: session[:vid_auth_session_id]}

    res1 = rc1.post data1.to_json, :content_type => 'application/vnd.veridiumid.sessionstatus-v1+json'
    rjs1 = JSON.parse(res1)
    puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    puts rjs1
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

    if rjs1["status"] == "COMPLETED"
      flash[:notice] = "Authentication successful"
      session[:username] = rjs1["data"]["upn"]
      profile_status = 'approved'
    elsif rjs1["status"] == "CREATED"
      profile_status = 'created'
    elsif rjs1["status"] == "OPPORTUNITY"
      profile_status = 'opportunity'
    else
      profile_status = 'denied'
    end

    render plain: profile_status
  end

end
