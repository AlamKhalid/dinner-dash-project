class Order < CartOrder
  validates :user_id, presence: true
end
