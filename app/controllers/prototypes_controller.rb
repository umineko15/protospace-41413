class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    redirect_to prototype_path
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
