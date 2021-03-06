class HousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :buy]
  before_action :autherize_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  
  def index
    @houses = House.order('created_at DESC')
  end

  def show
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      redirect_to @house, notice: 'New House Created Successfully'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @house.update(house_params)
      redirect_to @house, notice: 'Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @house.destroy
    redirect_to houses_path, notice: 'House Removed Successfully'
  end

  def buy
    if current_user.manager
      redirect_to root_path, notice: 'As a Manager youre not allowed to buy this home'
    else
      set_house
      very_long_task
      NotificationMailer.send_notification(@house.owner, current_user.email).deliver_now
      redirect_to @house, notice: 'Congratulations on Your New House!!!'
    end
  end

  private

  def house_params
    params.require(:house).permit(:owner, :address, :rooms, :sqmt, :floors, :air_cond, :price, :image)
  end

  def set_house
    @house = House.find(params[:id])
  end

  def autherize_manager
    unless current_user.manager
      redirect_to root_path, notice: 'Restricted Action'
    end
  end

  def very_long_task
    sleep 60
    true
  end
end
