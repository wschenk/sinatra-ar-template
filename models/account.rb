# models/account.rb
class Account < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_secure_password

  def to_json(*_args)
    { name:, id: }.to_json
  end
end
