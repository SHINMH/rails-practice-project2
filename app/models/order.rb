class Order < ApplicationRecord
  belongs_to :user, optional: true
  enum status: [:cart, :paid, :canceled]

  has_many :line_items, dependent: :nullify
end
