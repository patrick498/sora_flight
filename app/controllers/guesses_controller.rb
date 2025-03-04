class GuessesController < ApplicationController

  def index
  end

  def create
    @guess = Guess.new(guess_params)
    raise
    @guess.user = current_user
    authorize @guess
    if @guess.save
      redirect_to game_quiz_path(guess_id: @guess.id)
    else
      redirect_to game_quiz_path(guess_id: @guess.id), alert: 'Something went wrong'
    end
  end

  private
  def guess_params
    params.require(:guess).permit(:choice_id)
  end
end
