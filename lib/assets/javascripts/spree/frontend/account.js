Spree.fetch_account = function() {
  return $.ajax({
    url: Spree.pathFor("account_link"),
    success: function(data) {
      $('#top-nav-bar .link-to-account').remove();
      return $(data).insertBefore("li#search-bar");
    }
  });
};
