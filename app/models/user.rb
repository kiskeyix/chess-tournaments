class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  has_many :identities, dependent: :destroy
  has_and_belongs_to_many :messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    logger.debug "DEBUG: auth obj #{auth.inspect}"
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        full_name = auth.extra.raw_info.name.split(/\s+/)
        # we support 3 types of names:
        # 1. Foo Bar
        # 2. Foo Bar Baz
        # 3. Foo Bar Bas Baz
        fn = full_name.shift # everybody has a first name
        mn = full_name.shift if full_name.size >= 2 # some have a middle name
        ln = full_name.shift # most have last name
        sn = full_name.shift # some have surname

        user = User.new(
          firstname: fn || "",
          middlename: mn || "",
          lastname: ln || "",
          surname: sn || "",
          username: auth.info.nickname || auth.uid,
          image: auth.info.image || auth.info.picture || "",
          gender: auth.extra.gender || "",
          birthday: auth.extra.birthday || "",
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  def full_name
    "#{firstname.humanize} #{lastname.humanize}"
  end
end
