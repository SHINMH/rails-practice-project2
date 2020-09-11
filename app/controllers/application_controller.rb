class ApplicationController < ActionController::Base
  def get_cart
    # 현재 로그인한 유저가 가진 주문 중 cart 상태의 주문을 하나 찾아서 가져오거나
    # 없으면 하나 새로 생성함
    current_user.orders.cart.first_or_create
  end
end
