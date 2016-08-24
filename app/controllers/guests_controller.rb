class GuestsController < ApplicationController
  def new
    @guest = Guest.new
  end

  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def create
    @guest = Guest.new(guest_params)

    if @guest.save
      redirect_to guests_path
    else
      render "new"
    end
  end

  def update
    @guest = Guest.find(params[:id])

    if @guest.update(guest_params)
      redirect_to guests_path
    else
      render "edit"
    end
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    redirect_to guests_path
  end

  def guest_params
    params.require(:guest).permit(:id, :first_name, :last_name)
  end
end
