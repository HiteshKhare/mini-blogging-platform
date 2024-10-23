class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'guest'
  end

end
