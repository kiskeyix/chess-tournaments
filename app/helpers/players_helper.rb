module PlayersHelper
  def gravatar_image_url(user,format='pgn')
    # TODO add url encoded default image
    hashsum = Digest::MD5.hexdigest user.email
    "https://gravatar.com/avatar/#{hashsum}.#{format}"
  end
end
