require 'rqrcode'

Spree::Admin::UsersController.class_eval do
  before_action :generate_qr_code, only: :edit

  private

  def generate_qr_code
    return unless @object.otp_required_for_login

    issuer = Spree::Store.default.name
    uri = @object.otp_provisioning_uri(@object.email, issuer: issuer)
    qrcode = RQRCode::QRCode.new(uri)
    @qr_svg = qrcode.as_svg(module_size: 5)
  end
end
