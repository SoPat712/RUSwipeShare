import os
import stripe

from flask import Flask, jsonify, redirect, request

app = Flask(__name__)

#http://localhost:5000/payment-sheet?price=10
pagelock = False
@app.route('/payment-sheet', methods=['GET'])
def payment_sheet():

# Set your secret key. Remember to switch to your live secret key in production.
# See your keys here: https://dashboard.stripe.com/apikeys
    stripe.api_key = 'sk_test_51MfY7PFVdcWv896F4M60UlEKZAMt1SCxaOumRrr8op3qQXVa369wrPjVgAD0EtedXxbMtaJlrEFGihYFtioHfwfR007W67IuWG'
  # Use an existing Customer ID if this is a returning customer
    customer = stripe.Customer.create()
    ephemeralKey = stripe.EphemeralKey.create(
    customer=customer['id'],
    stripe_version='2022-11-15',
  )
    paymentIntent = stripe.PaymentIntent.create(
    amount=int(request.args.get("price")),
    currency='usd',
    customer=customer['id'],
    automatic_payment_methods={
      'enabled': True,
    },
  )
    return jsonify(paymentIntent=paymentIntent.client_secret,
                 ephemeralKey=ephemeralKey.secret,
                 customer=customer.id,
                 publishableKey='pk_test_51MfY7PFVdcWv896FKvDhgKabYeDq4AnoFcWxCAg4hquj6TBAsN0kznXPVyKA7M1pMq5PsieGQwsx6QY5ld5ZQzJ500rVCMPPXp')

@app.route('/setup-seller', methods=['GET'])
def setup_seller():
    stripe.api_key = 'sk_test_51MfY7PFVdcWv896F4M60UlEKZAMt1SCxaOumRrr8op3qQXVa369wrPjVgAD0EtedXxbMtaJlrEFGihYFtioHfwfR007W67IuWG'
    id = stripe.Account.create(type="express")
    pagelock = True
    return stripe.AccountLink.create(
  account=id,
  refresh_url="http://localhost:5000/reauth",
  return_url="http://localhost:5000/returnb",
  type="account_onboarding",
)

@app.route('/returnb', methods=['GET'])
def returnb():
    pagelock =False

@app.route('/checklock', methods=['GET'])
def checklock():
    return pagelock




if __name__== '__main__':
    app.run(port=4242)