class Item < ApplicationRecord
	mount_uploader :image, ImageUploader # 이미지 첨부를 위해 이 부분 추가

  belongs_to :user, optional: true
  belongs_to :category, optional: true
end
