[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

A sample project to demonstrate the capabilities of IEEE 2410-2017

1. Generate a FRIEND certificate on the BOPS server (see an Administrator)
2. Extract public cert and private key from p12 file:

~~~~
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.crt.pem -clcerts -nokeys
% openssl pkcs12 -in FRIEND.p12 -out FRIEND.key.pem -nocerts -nodes
~~~~

2. Enroll using the Veridium Authenticator app (available on App Store and Play Store) on your mobile device.  You will need an account from the Administrator to enroll.
3. Clone this repo and execute the following commands (assuming you have Rails installed)

~~~~
% cd bops-heroku-demo
% bundle install
% export EXTERNALID=<External Adaptor ID>
% export BOPSSRV=<Your VeridiumID server like bops.example.com>
% export FRIENDCERT="$(cat FRIEND.crt.pem)"
% export FRIENDPRIVKEY="$(cat FRIEND.key.pem)"
% bundle exec rails s
~~~~

4. Open a browser to http://localhost:3000/
6. Open the Veridium Authenticator app on your mobile device
7. Click "Log in" on the web site via your browser
8. Use the QR code or Email-based methods for authentication

You can also deploy the app on Heroku:

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
