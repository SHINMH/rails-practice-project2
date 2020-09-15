class Comment < ApplicationRecord
  paginates_per 5
  belongs_to :user
  belongs_to :item
end
