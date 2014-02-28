# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# Uview20140227::Application.config.secret_token = 'e7bd633e2a18c3f2df552081f351e614af8235d2d3fb99918e41f39e45d38caa9acaf627bdc008b0efdc933c5fc20b9ba07b6eafe06606690eadb7038865afae'
require 'securerandom'
def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
end end
Uview20140227::Application.config.secret_key_base = secure_token