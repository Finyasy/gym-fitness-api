class Member < ApplicationRecord
  has_many :payments, dependent: :destroy

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, presence: true
  validates :membership_type, presence: true
  validates :status, presence: true, inclusion: { in: %w[active inactive suspended] }

  before_save :set_default_status

  private

  def set_default_status
    self.status ||= 'active'
  end
end
