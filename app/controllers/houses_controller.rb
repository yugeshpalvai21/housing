class HousesController < ApplicationController
  def index
    @houses = House.order('created_at DESC')
  end

  def show
    @house = House.find(params[:id])
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
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update(house_params)
      redirect_to @house, notice: 'Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to houses_path, notice: 'House Removed Successfully'
  end

  private

  def house_params
    params.require(:house).permit(:owner, :address, :rooms, :sqmt, :floors, :air_cond, :price)
  end
end
