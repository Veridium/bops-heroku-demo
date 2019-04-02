[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy) [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/68e1d0a5d7b0f6455029)

A sample project to demonstrate the capabilities of IEEE 2410-2017

API Calls

This project demonstrates the 3 core API calls and you can see them in action in profile_controller.rb and session_controller.rb

1. requestAuthentication - brief description ****************

2. getStatus - brief description ****************

3. createsessionOpportunity - brief description ****************

Prerequisites

Access to a BOPS server

Generate or request a p12 Friend certificate from BOPS server (see an Administrator)

Extract public cert and private key from p12 file:

~~~~
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.crt.pem -clcerts -nokeys
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.key.pem -nocerts -nodes
~~~~

User account and password to enroll a mobile. (see an Administrator)

Enrollment QR code (see an Administrator)

EXTERNALID=<External Adaptor ID> (see an Administrator)

BOPSSRV=<Your VeridiumID server like bops.example.com> (see an Administrator)

iOS or Android phone with access to App Store

App Deployment Options

1. Run in Postman (see link at top)

2. Deploy to Heroku (see link at top)

Or to deploy manually
~~~~
% cd bops-heroku-demo
% heroku create
% git push heroku master
% heroku config:set EXTERNALID=<External Adaptor ID>
% heroku config:set BOPSSRV=<Your VeridiumID server like bops.example.com>
% heroku config:set FRIENDCERT="$(cat FRIEND.crt.pem)"
% heroku config:set FRIENDPRIVKEY="$(cat FRIEND.key.pem)"
% heroku open
~~~~

3. Build locally
Clone this repo and execute the following commands (assuming you have Rails installed)

~~~~
% cd bops-heroku-demo
% bundle install
% export EXTERNALID=<External Adaptor ID>
% export BOPSSRV=<Your VeridiumID server like bops.example.com>
% export FRIENDCERT="$(cat FRIEND.crt.pem)"
% export FRIENDPRIVKEY="$(cat FRIEND.key.pem)"
% bundle exec rails s
~~~~

Test

Install the Veridium Authenticator app (available on App Store and Play Store) on your mobile device.

Enroll - Open the app, tap Scan QR CODE and  scan QR code provided by administrator

On Heroku

                On a PC/Mac - Open a browser to your heroku app

On Postman
                On a PC/Mac - ***************************

On local build

                On a PC/Mac - Open a browser to http://localhost:3000/


Open the Veridium Authenticator app on your mobile device

Click "Log in" on the web site via your browser and choose Authentication Method

Auth Method QR - Use the QR code (select enrolled name in the mobile app and scan) **or**

Auth Method PUSH - enter your account/email as displayed in the app (for authentication via Push-notification)

 
