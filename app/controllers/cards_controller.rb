class CardsController < ApplicationController
  def new
    @board = current_user.boards.find(params[:board_id])
    @card = @board.cards.new
  end

  def create
    @board = current_user.boards.find(params[:board_id])
    @list = @board.lists.find(params.dig(:card, :list_id))
    @card = @list.cards.build(card_params)

    if @card.save
      redirect_to board_path(@board), notice: "Card added!"
    else
      @lists = @board.lists.includes(:cards)
      render "boards/show", status: :unprocessable_entity
    end
  end

  def update_position
    @card = current_user.cards.find(params[:id])
    @list = current_user.lists.find(params[:list_id])

    if @card.list_id != @list.id
      @card.insert_at(1)
      @card.update!(list: @list)
    end

    @card.insert_at(params[:position].to_i)
    head :ok

    rescue => e
      render plain: e.message, status: :unprocessable_entity
  end

  def destroy
    @board = current_user.boards.find(params[:board_id])
    @list = @board.lists.find(params[:id])
    @card = @list.cards.find(params[:card_id])
    @card.destroy

    redirect_to board_path(@board), notice: "Card deleted.", status: :see_other
  end

  private

  def card_params
    params.require(:card).permit(:title)
  end
end
