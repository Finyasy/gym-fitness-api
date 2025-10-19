class Payment < ApplicationRecord
  belongs_to :member

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_date, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true, inclusion: { in: %w[completed pending failed] }

  before_save :set_default_status

  private

  def set_default_status
    self.status ||= 'completed'
  end
end
