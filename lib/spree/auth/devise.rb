require 'spree/core'
require 'devise'
require 'devise-encryptable'
require 'devise-two-factor'
require 'cancan'

Devise.secret_key = SecureRandom.hex(50)

module Spree
  module Auth
    mattr_accessor :default_secret_key

    def self.config
      yield(Spree::Auth::Config)
    end
  end
end

Spree::Auth.default_secret_key = Devise.secret_key
Spree::PermittedAttributes.user_attributes.push(:otp_required_for_login, :otp_attempt)

require 'spree/auth/engine'
