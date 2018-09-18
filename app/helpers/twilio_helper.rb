module TwilioHelper
  def self.get_username(phone_number)
    hash = {"2153607906" => "john.zxcvbnm.smith@gmail.com"}
    key = hash.keys.detect{ |key| key.in?(phone_number) }
    hash[key]
  end
end
