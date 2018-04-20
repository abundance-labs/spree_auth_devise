Deface::Override.new(
  virtual_path: 'spree/admin/users/_form',
  name: 'Add 2FA in users form',
  insert_bottom: 'div[data-hook="admin_user_form_password_fields"]',
  text: <<-HTML
          <%= f.field_container :otp_required_for_login, class: ['form-group'] do %>
            <%= f.label :otp_required_for_login, Spree.t(:otp_required_for_login) %>
            <%= f.check_box :otp_required_for_login, class: 'form-control' %>
          <% end %>

          <% if @qr_svg %>
            <label><%= Spree.t(:authenticator_qr_code) %></label>
            <br>
            <%= raw @qr_svg %>
            <br>
            <a href='https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8'>Download Google Authenticator for iOS</a>
            <br>
            <a href='https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US'>Download Google Authenticator for Android</a>
            <br>
            Once 2FA is enabled, you can reach your login URL at: https://staging.public.market/dashboard/login
          <% end %>
        HTML
)
