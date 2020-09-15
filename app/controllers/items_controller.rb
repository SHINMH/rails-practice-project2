# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show] # 찜하기는 로그인 해야지만 이용 가능
  before_action :load_object, only: %i[show toggle edit update destroy add test] # 상품 상세와 찜하기는 @item을 먼저 불러옴
  before_action :check_owner, only: %i[edit update destroy] # 수정/삭제는 상품 소유자만 할 수 있도록

  def index
    if params[:type] == 'selling'
      redirect_to root_path, notice: '로그인을 해야 합니다' unless current_user
      @items = current_user.items
    else
      @items = Item.all
      # 카테고리별 페이지
      if params[:category_id].present?
        @category = Category.find(params[:category_id])
        @items = @items.where(category_id: params[:category_id])
      end
    end
    if params[:q].present?
      @items = @items.ransack(title_or_description_cont: params[:q]).result(distinct: true)
    end
    @items = params[:order].blank? ? @items.order(created_at: :desc) : @items.order(params[:order])
    @items = @items.page(params[:page]).per(20)
  end

  def toggle
    if user_item = current_user.user_items.where(item: @item).first
      # 이미 찜한 상태라면 찜을 제거
      user_item.destroy
      flash[:notice] = '찜을 제거하였습니다.'
    else
      # 찜한 적이 없으면 찜하기
      current_user.user_items.where(item: @item).create
      flash[:notice] = '찜하였습니다.'
    end
    redirect_to @item
  end

  def add
    # edit은 판매자가 상품 편집을 하는데 사용해야 하므로
    @order = get_cart
    line_item = @order.line_items.where(item: @item).first_or_create(price: @item.price)
    line_item.increment!(:amount)
    line_item.set_order_total
    redirect_to new_order_path, notice: '장바구니에 상품을 담았습니다.'
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    @item.update(user: current_user)
    redirect_to items_path(type: :selling), notice: '상품을 등록했습니다'
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to items_path(type: :selling), notice: '상품을 등록했습니다'
  end

  def show
  end

  def destroy
    @item.destroy
    redirect_back fallback_location: root_path
  end

  private

  def load_object
    @item = Item.find params[:id]
  end

  def item_params
    params.require(:item).permit(:title, :price, :description, :image, :category_id)
  end

  def check_owner
    redirect_to root_path, notice: '권한이 없습니다' unless @item.user == current_user
  end
end
