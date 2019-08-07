class Message
  def self.not_found(record = "record")
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    "Invalid credentials"
  end

  def self.invalid_token
    "Invalid token"
  end

  def self.missing_token
    "Missing token"
  end

  def self.unauthorized
    "Unauthorized request"
  end

  def self.account_created
    "Account created successfully"
  end

  def self.account_not_created
    "Account could not be created"
  end

  def self.expired_token
    "Sorry, your token has expired. Please login to continue."
  end

  def self.missing_params
    { code: 104, message: "Insufficient params supplied." }
  end

  def self.saving_error
    { code: 105, message: "Error saving to database." }
  end

  def self.username_already_taken
    { code: 106, message: "Username already taken." }
  end

  def self.data_not_found
    { code: 107, message: "Data not found." }
  end

  def self.not_allowed
    { code: 108, message: "User not allowed to do this action." }
  end
end
