class ListsController < ApplicationController
  def index
    @board = current_user.boards.find(params[:board_id])
    @lists = @board.lists
  end

  def new
    @board = current_user.boards.find(params[:board_id])
    @list = @board.lists.new
  end

  def create
    @board = current_user.boards.find(params[:board_id])
    @list = @board.lists.create(list_params)
    if @list.save
      redirect_to board_path(@board), notice: "List created successfully"
    else
      @lists = @board.lists.includes(:cards)
      render "boards/show", status: :unprocessable_entity
    end
  end

  def destroy
    @board = current_user.boards.find(params[:board_id])
    @list = @board.lists.find(params[:id])
    @list.destroy

    redirect_to board_path(@board), notice: "List deleted.", status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
