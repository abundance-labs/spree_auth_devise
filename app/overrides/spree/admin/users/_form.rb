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
          <% end %>
        HTML
)
