require 'json'
require 'rest-client'

class SessionsController < ApplicationController
  def new
    privkey = OpenSSL::PKey::RSA.new ENV['FRIENDPRIVKEY']
    friendcert = OpenSSL::X509::Certificate.new ENV['FRIENDCERT']

    rc1 = RestClient::Resource.new(
	"https://#{ENV['BOPSSRV']}/websec/rest/enterprise/RegisterSessionOpportunity",
	:ssl_client_cert => friendcert,
	:ssl_client_key => privkey,
	:verify_ssl => false)

    data1 = {sessionAliasType: "QR", memberExternalId: ENV['EXTERNALID']}

    res1 = rc1.post data1.to_json, :content_type => 'application/vnd.veridiumid.sessionOpportunity-v2+json'
    puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    puts res1
    puts "=================================================="
    rjs1 = JSON.parse(res1)
    @qrcode = rjs1["sessionAlias"]
    session[:vid_auth_session_id] = rjs1["sessionId"]
    puts rjs1
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  end

  def create
    veridiumid = {'success' => true}

    privkey = OpenSSL::PKey::RSA.new ENV['FRIENDPRIVKEY']
    friendcert = OpenSSL::X509::Certificate.new ENV['FRIENDCERT']

    rc1 = RestClient::Resource.new(
	"https://#{ENV['BOPSSRV']}/websec/rest/enterprise/AuthenticationRequest",
	:ssl_client_cert => friendcert,
	:ssl_client_key => privkey,
	:verify_ssl => false)

    data1 = {memberExternalId: ENV['EXTERNALID'],authenticationMode: "",profileExternalId: params[:email],extraValues: "",transactionText: ""}

    res1 = rc1.post data1.to_json, :content_type => 'application/vnd.veridiumid.authenticationrequest-v1+json'
    puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    puts res1
    puts "=================================================="
    rjs1 = JSON.parse(res1)
    puts rjs1
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    session[:vid_auth_session_id] = rjs1["sessionId"]

    status = veridiumid['success'] ? :veridium : :sms

    # Respond to the ajax call that requested this with the approval request body
    render json: { success: veridiumid['success'] }
  end

  def fail
    session[:username] = nil
    flash[:notice] = "Authentication unsuccessful"
    redirect_to root_path
  end

  def destroy
    session[:username] = nil
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end
end
