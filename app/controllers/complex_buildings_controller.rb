class ComplexBuildingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :buy]
  before_action :autherize_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_complex_building, only: [:show, :edit, :update, :destroy]

  def index
    @complex_buildings = ComplexBuilding.order('created_at DESC')
  end

  def show
  end

  def new
    @complex_building = ComplexBuilding.new
  end

  def create
    @complex_building = ComplexBuilding.new(complex_building_params)

    if @complex_building.save
      redirect_to @complex_building, notice: 'New Complex Building Created Successfully'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @complex_building.update(complex_building_params)
      redirect_to @complex_building, notice: 'Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @complex_building.destroy
    redirect_to houses_path, notice: 'House Removed Successfully'
  end

  def buy
    if current_user.manager
      redirect_to root_path, notice: 'As a Manager youre not allowed to buy this home'
    else
      set_complex_building
      very_long_task
      NotificationMailer.send_notification(@complex_building.owner, current_user.email).deliver_now
      redirect_to @complex_building, notice: 'Congratulations on Your New House!!!'
    end
  end

  private

  def complex_building_params
    params.require(:complex_building).permit(:owner, :address, :units, :sqmt, :price, :image)
  end

  def set_complex_building
    @complex_building = ComplexBuilding.find(params[:id])
  end

  def autherize_manager
    unless current_user.manager
      redirect_to root_path, notice: 'Restricted Action'
    end
  end

  def very_long_task
    sleep 30
    true
  end
end
