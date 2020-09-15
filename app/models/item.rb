class Item < ApplicationRecord
	mount_uploader :image, ImageUploader # 이미지 첨부를 위해 이 부분 추가

  belongs_to :user, optional: true
  belongs_to :category, optional: true

  has_many :line_items, dependent: :nullify
  # 상품이 삭제되도 주문 항목은 삭제되면 안됨
  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items
  has_many :comments, dependent: :destroy
  # 찜하기는 상품이 삭제되면 삭제되어도 될 듯 

  def self.generate_items
    %w(아이폰 안드로이드 아이패드 맥북 시계 애플와치 갤럭시기어).each do |title|
      category = Category.first
      Item.create(title: title, price: 100000, category: category, image: Item.first.image, user: User.first, description:"상세한 설명이 있습니다")
    end
  end
end
 