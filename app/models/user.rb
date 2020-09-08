class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_items, dependent: :destroy # 찜하기는 회원이 삭제되거나 탈퇴하면 지워져도 됨
  has_many :items, dependent: :nullify # 등록된 상품을 등록한 회원이 삭제되더라도 주문이나 리뷰 등 
  #  다른 데이터와 많이 엮여 있어서 삭제하지 않고 foreign_key만 null로 갱신
    

  def has_item? item
    user_items.where(item: item).present?
  end
  
end
