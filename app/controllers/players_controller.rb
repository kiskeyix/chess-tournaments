class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    if params[:search] or params[:term]
      c = params[:search] || params[:term]
      @players = Player.paginate(:page => params[:page],
                                 :per_page => 20).where("players.name LIKE ?", "#{c}%")
    else
      @players = Player.paginate(page: params[:page], per_page: 15)
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    if current_user.player.nil? or current_user.admin?
      @player = Player.new
      unless current_user.admin?
        @player.name = current_user.full_name
        @player.image = current_user.image
        @player.gender = current_user.gender
        @player.user_id = current_user.id
      end
    else
      redirect_to root_path, alert: 'Player aleady associated with this account.'
    end
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    if current_user.player.nil? or current_user.admin?
      @player = Player.new(player_params)

      respond_to do |format|
        if @player.save
          format.html { redirect_to @player, notice: 'Player was successfully created.' }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: 'Player aleady associated with this account.'
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    #@player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, alert: 'Players cannot be removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:user_id, :name, :nationality, :gender, :image)
    end
end
