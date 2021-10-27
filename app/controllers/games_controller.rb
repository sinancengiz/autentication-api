class GamesController < ApplicationController
    before_action :set_game, only: [:join_to_game, :get_game_users, :quit_from_game, :show, :update, :destroy, :start_game, :atack]
    before_action :set_user, only: [:join_to_game, :get_game_users, :quit_from_game, :create, :show, :update, :destroy, :start_game, :select_capital, :select_color, :atack]

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
    @game_response = {game: @game, castles: @game.castles.order(:id)}
    json_response(@game_response, :created)
  end

  # PUT /games/:id
  def update
    @game.update(game_params)
    @game_response = {game: @game, castles: @game.castles.order(:id)}
    json_response(@game_response, :created)
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
            castle = Castle.last
            castle.user_id = user.id
            castle.save
          end
        end        
      end

      @start_game_response = {game: @game, castles: @game.castles}
      json_response(@start_game_response, :created)
    else
      json_response({message: "Only creator can start the game"}, :created)
    end
  end

  # PUT /games/:id/select_capital
  def select_capital
    @user.capital = params[:capital]
    if @user.save
      json_response(@user, :created)
    else
      json_response({message: "Capital selection failed"}, :created)
    end
  end

  # PUT /games/:id/select_color
  def select_color
    @user.color = params[:color]
    if @user.save
      json_response(@user, :created)
    else
      json_response({message: "Color selection failed"}, :created)
    end
  end

  # PUT /games/:id/atack
  def atack
    atack_castle = Castle.find(params[:atack_castle])
    defense_castle = Castle.find(params[:defense_castle])
    atack_power = params[:army].to_i
    defense_power = defense_castle.army
    if atack_castle.user_id == @user.id && defense_castle.user_id != @user.id
      if atack_castle.army >= params[:army].to_i
        if defense_power >= atack_power
          defense_castle.population -= atack_power
          defense_castle.army -= atack_power
          defense_castle.save
          atack_castle.population -= atack_power
          atack_castle.army -= atack_power
          atack_castle.save
          json_response({message: "Atack unsuccessful"}, :created)
        else
          if check_if_last_castle(defense_castle.user_id)
            lost_user = User.find(defense_castle.user_id)
            lost_user.color = nil
            lost_user.capital = nil
            lost_user.lost += 1
            lost_user.save
          end
          if check_if_last_user(@game.id)
            @game.destroy_game
            @user.current_game = nil
            @user.color = nil
            @user.capital = nil
            @user.won += 1
            @user.save
            json_response({message: "Game You Won"}, :created)
          end
          left_army = atack_power - defense_power
          defense_castle.population = left_army
          defense_castle.gold_worker = 0
          defense_castle.wood_worker = 0
          defense_castle.stone_worker = 0
          defense_castle.farm_worker = 0
          defense_castle.iron_worker = 0
          defense_castle.idle_population = 0
          defense_castle.army = left_army
          defense_castle.user_id = atack_castle.user_id
          defense_castle.save
          atack_castle.population -= atack_power
          atack_castle.army -= atack_power
          atack_castle.save
          json_response({message: "Atack successful"}, :created)
        end
      else
        json_response({message: "Not enough army in the Castle to make this attack"}, :created)
      end
    else
      json_response({message: "You can't atack this castle"}, :created)
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

  def check_if_last_castle(user_id)
    if User.find(user_id).castles.length == 1
      return true
    else
      return false
    end  
  end
  def check_if_last_user(game_id)
    if Game.find(game_id).users.length == 1
      return true
    else
      return false
    end  
  end
end
