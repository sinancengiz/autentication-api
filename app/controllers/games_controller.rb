class GamesController < ApplicationController
    before_action :set_game, only: [:join_to_game, :get_game_users, :quit_from_game, :show, :update, :destroy, :start_game]
    before_action :set_user, only: [:join_to_game, :get_game_users, :quit_from_game, :create, :show, :update, :destroy, :start_game]

  # GET /games
  def index
    @games = Game.where("player_count < ?", 5)
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
    else
      json_response({message: "You are already in a game"}, :created)
    end
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

  # POST /games/:id
  def join_to_game
    if current_user.current_game.nil?
      if @game.player_count < 4
        @game.users << current_user
        @user.current_game = @game.id
        @game.player_count += 1
        @game.save
        @user.save
        head :no_content
      else
        json_response({message: "Game is full"}, :created)
      end
    else
      json_response({message: "You are already in a game"}, :created)
    end
  end

  # POST /games/:id/quit_game
  def quit_from_game
    if @game.created_by == @user.id
      @game.destroy_game
      json_response({message: "Game deleted"}, :created)
    else
      if !@user.current_game.nil? && @user.current_game == @game.id
        @game.player_count -= 1
        @game.save
      end
      @user.current_game = nil
      @user.save
      @game.users.delete(@user)
      json_response({message: "You are not in a game"}, :created) 
    end
  end

  # GET /games/:id/users
  def get_game_users
    json_response(@game.users, :created)
  end

  # POST /games/:id/start_game
  def start_game
    if @user.current_game && @game.created_by == @user.id
      @game = Game.find(@user.current_game)
      @game.started = true
      @game.save
      @castles = @game.initial_castles.shuffle
      @castles.each do |castle|
        Castle.create(castle)
        @game.castles << Castle.last
        @game.users.each do |user|
          if user.capital == castle[:name]
            Castle.last.users << user
          end
        end        
      end

      @start_game_response = {game: @game, castles: @game.castles}
      json_response(@start_game_response, :created)
    else
      json_response({message: "Only creator can start the game"}, :created)
    end
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
