class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.boards
  end

  def show
    @board = Board.find(params[:id])
    @list = List.new
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.create(board_params)
    if @board.save
      redirect_to @board, notice: "Board created successfully"
    else
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
