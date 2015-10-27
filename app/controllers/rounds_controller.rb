class RoundsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @tournament = Tournament.find params[:tournament_id]
    @rounds = @tournament.rounds
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    if current_user.admin?
      @tournament = Tournament.find params[:tournament_id]
      @round = @tournament.rounds.new
    else
      msg = { alert: "Only administrators can create or manipulate rounds. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /rounds/1/edit
  def edit
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, alert: "You are not a site admin. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
      return
    end
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)
    if current_user.admin?
      respond_to do |format|
        if @round.save
          format.html { redirect_to @round, notice: 'Round was successfully created.' }
          format.json { render :show, status: :created, location: @round }
        else
          format.html { render :new }
          format.json { render json: @round.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate rounds. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { render :new, msg }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @round.update(round_params)
          format.html { redirect_to @round, notice: 'Round was successfully updated.' }
          format.json { render :show, status: :ok, location: @round }
        else
          format.html { render :edit }
          format.json { render json: @round.errors, status: :unprocessable_entity }
        end
      end
    else
      @tournament = @round.tournament
      msg = { alert: "Only administrators can create or manipulate rounds. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to tournament_url(@tournament), msg }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @tournament = @round.tournament
    if current_user.admin?
      @round.destroy
      respond_to do |format|
        format.html { redirect_to tournament_url(@tournament), notice: 'Round was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        msg = { alert: "Only administrators can create or manipulate rounds. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
        format.html { redirect_to tournament_url(@tournament), msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:name, :description, :start_date, :end_date, :tournament_id)
    end
end
