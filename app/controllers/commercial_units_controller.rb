class CommercialUnitsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :buy]
  before_action :autherize_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_commercial_unit, only: [:show, :edit, :update, :destroy]
  
  def index
    @commercial_units = CommercialUnit.order('created_at DESC')
  end

  def show
  end

  def new
    @commercial_unit = CommercialUnit.new
  end

  def create
    @commercial_unit = CommercialUnit.new(commercial_unit_params)
    if @commercial_unit.save
      redirect_to @commercial_unit, notice: 'New Commercial Unit Created Successfully'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @commercial_unit.update(commercial_unit_params)
      redirect_to @commercial_unit, notice: 'Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @commercial_unit.destroy
    redirect_to commercial_units_path, notice: 'Commercial Unit Removed Successfully'
  end

  def buy
    if current_user.manager
      redirect_to root_path, notice: 'As a Manager youre not allowed to buy this home'
    else
      set_commercial_unit
      very_long_task
      NotificationMailer.send_notification(@commercial_unit.owner, current_user.email)
      redirect_to @commercial_unit, notice: 'Congratulations on Your New House!!!'
    end
  end

  private

  def commercial_unit_params
    params.require(:commercial_unit).permit(:owner, :address, :shops, :parking, :price, :image)
  end

  def set_commercial_unit
    @commercial_unit = CommercialUnit.find(params[:id])
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
