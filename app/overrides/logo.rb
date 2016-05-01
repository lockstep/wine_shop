Deface::Override.new(:virtual_path => 'spree/shared/_header',
  :name => 'logo',
  :replace_contents => "#logo",
  :text => "
    <%= link_to root_path do %>
    <%= image_tag 'logo.png', alt: 'GetWineOnline.com' %>
    <% end %>
  ")
