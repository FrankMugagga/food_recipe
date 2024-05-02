class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes
  has_many :foods
  has_many :inventories

  validates :name, :email, :password, :password_confirmation, presence: { message: "missing value, cant't be blank" }

  validate :password_complexity

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\W]).{8,70}$/

    errors.add :password,
               'password complexity requirement not met. \n
               Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end
end
