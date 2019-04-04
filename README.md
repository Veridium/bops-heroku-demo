[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy) [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/68e1d0a5d7b0f6455029)

A sample project to demonstrate the capabilities of IEEE 2410-2017

# API Calls

This project demonstrates the 3 core API calls and you can see them in action in profile_controller.rb and session_controller.rb

1. AuthenticationRequest - Register an authentication request (server is initiating the authentication session asking an authentication device to step in). The phone will receive a push notification ‘authenticate’-NOTIFICATION_AUTHENTICATE

2. GetSessionStatus - Returns the status of the session

3. RegisterSessionOpportunity - Register a new session opportunity. Returns QR code.

# Prerequisites

Access to a BOPS server (see an Administrator)

Generate or request a p12 Friend certificate from BOPS server (see an Administrator)

Extract public cert and private key from p12 file:

~~~~
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.crt.pem -clcerts -nokeys
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.key.pem -nocerts -nodes
~~~~

User account, password, and email values to enroll a mobile. (see an Administrator)

Enrollment QR code (see an Administrator)

EXTERNALID=<External Adaptor ID> (see an Administrator)

BOPSSRV=<Your VeridiumID server like bops.example.com> (see an Administrator)

iOS or Android phone with access to App Store

# App Deployment Options

1. Run in Postman (see link at top) . <br/><br/>
You can exercise the APIs within a Postman collection.  <br/>
    On a PC/Mac - Open Postman to your imported BOPS demo collection . <br/>
    Create an environment and set . <br/>
       * url=your BOPSSRV value . <br/>
       * email=your assigned email value . <br/>
    Add the client certificate and key for BOPSSRV to your Postman certificates in Settings.  

2. Deploy to Heroku (see link at top) and populate the Config Vars

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

# Test

Install the Veridium Authenticator app (available on App Store and Play Store) on your mobile device.

Enroll - Open the app, tap Scan QR CODE and  scan QR code provided by administrator

Open the Veridium Authenticator app on your mobile device

## Heroku or Local Build
On Heroku
    On a PC/Mac - open a browser to your heroku app

On local build
     On a PC/Mac - open a browser to http://localhost:3000

Click "Log in" on the web site via your browser and choose Authentication Method

Auth Method QR - Use the QR code (select enrolled name in the mobile app and scan) **or**

Auth Method PUSH - enter your account/email as displayed in the app (for authentication via Push-notification)

## Postman
On Postman

   On a PC/Mac - Open Postman to BOPS collection and test APIs
 
