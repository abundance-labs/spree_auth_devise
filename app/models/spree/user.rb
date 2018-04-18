module Spree
  class User < Spree::Base
    include UserAddress
    include UserMethods
    include UserPaymentSource

    devise :two_factor_authenticatable, :registerable, :recoverable,
           :rememberable, :trackable, :validatable,
           otp_secret_encryption_key: ENV['OTP_SECRET']
    devise :confirmable if Spree::Auth::Config[:confirmable]
    devise :encryptable, encryptor: 'authlogic_sha512'

    acts_as_paranoid
    after_destroy :scramble_email_and_password

    before_validation :set_login
    before_save :assign_otp_secret, if: :otp_required_for_login_changed?

    users_table_name = User.table_name
    roles_table_name = Role.table_name

    scope :admin, -> { includes(:spree_roles).where("#{roles_table_name}.name" => "admin") }

    def self.admin_created?
      User.admin.exists?
    end

    def admin?
      has_spree_role?('admin')
    end

    protected

    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end

    private

    def set_login
      # for now force login to be same as email, eventually we will make this configurable, etc.
      self.login ||= email if email
    end

    def scramble_email_and_password
      self.email = SecureRandom.uuid + "@example.net"
      self.login = email
      self.password = SecureRandom.hex(8)
      self.password_confirmation = password
      save
    end

    def assign_otp_secret
      self.otp_secret = User.generate_otp_secret if otp_secret.blank?
    end
  end
end
