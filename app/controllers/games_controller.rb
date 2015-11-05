class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  # GET /players/:player_id/games
  # GET /players/:player_id/games.json
  def index
    if params[:player_id]
      @games = Game.where('white_player_id = ? OR black_player_id = ?',
                          params[:player_id],
                          params[:player_id]).paginate(page: params[:page], per_page: 15)
    else
      @games = Game.paginate(page: params[:page], per_page: 15)
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    @game.white_player = Player.new
    @game.black_player = Player.new
    @game.pgn = ""
  end

  # GET /players/:player_id/games/1/edit
  def edit
  end

  # POST /players/:player_id/games
  # POST /players/:player_id/games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to player_game_path(current_user.player,@game), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/:player_id/games/1
  # PATCH/PUT /players/:player_id/games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to player_game_path(current_user.player,@game), notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/:player_id/games/1
  # DELETE /players/:player_id/games/1.json
  def destroy
    if [@game.white_player, @game.black_player].include? current_user.player
      @game.destroy
      respond_to do |format|
        format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not allowed to remove this game.' }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:event,
                                   :name,
                                   :date,
                                   :timecontrol,
                                   :white_player_id,
                                   :white_elo,
                                   :black_player_id,
                                   :black_elo,
                                   :site,
                                   :result,
                                   :fen,
                                   :pgn,
                                   :division_id)
    end
end
