class GamesController < ApplicationController
    before_action :set_game, only: [:join_to_game, :get_game_users, :quit_from_game, :show, :update, :destroy]
    before_action :set_user, only: [:join_to_game, :get_game_users, :quit_from_game, :create, :show, :update, :destroy]

  # GET /games
  def index
    @games = Game.all
    json_response(@games)
  end

  # POST /games
  def create
    if current_user.current_game.nil?
      @game = Game.create!(game_params)
      @game.users << current_user
      @user.current_game = @game.id
      @user.save
      json_response(@game, :created)
    end
  end

  # POST /games/:id
  def join_to_game
    if current_user.current_game.nil?
      @game.users << current_user
      @user.current_game = @game.id
      @user.save
      head :no_content
    end
  end

  # POST /games/:id/users/:user_id
  def quit_from_game
    if !@user.current_game.nil?
      @user.current_game = nil
      @user.save
      @game.users.delete(@user)
    end
  end

  # GET /games/:id/users
  def get_game_users
    json_response(@game.users, :created)
  end

  # GET /games/:id
  def show
    json_response(@game)
  end

  # PUT /games/:id
  def update
    @game.update(game_params)
    head :no_content
  end

  # DELETE /games/:id
  def destroy
    return unless @game.created_by == @user.id
    @game.destroy_game
    head :no_content
  end

  private

  def game_params
    # whitelist params
    params.permit(:title).merge(:player_count => 1, :started => false, :finished => false, created_by: current_user.id)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
