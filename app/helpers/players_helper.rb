module PlayersHelper
  def gravatar_image_url(user,format='pgn')
    # TODO add url encoded default image
    "https://gravatar.com/avatar/#{gravatar_id(user.email)}.#{format}"
  end
  def gravatar_id(email)
    Digest::MD5.hexdigest(email.to_s.downcase)
  end
end
