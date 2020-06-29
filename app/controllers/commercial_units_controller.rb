class CommercialUnitsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :autherize_manager, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @commercial_units = CommercialUnit.order('created_at DESC')
  end

  def show
    @commercial_unit = CommercialUnit.find(params[:id])
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
    @commercial_unit = CommercialUnit.find(params[:id])
  end

  def update
    @commercial_unit = CommercialUnit.find(params[:id])
    if @commercial_unit.update(commercial_unit_params)
      redirect_to @commercial_unit, notice: 'Updated Successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @commercial_unit = CommercialUnit.find(params[:id])
    @commercial_unit.destroy
    redirect_to commercial_units_path, notice: 'Commercial Unit Removed Successfully'
  end

  private

  def commercial_unit_params
    params.require(:commercial_unit).permit(:owner, :address, :shops, :parking, :price)
  end

  def autherize_manager
    unless current_user.manager
      redirect_to root_path, notice: 'Restricted Action'
    end
  end
end
