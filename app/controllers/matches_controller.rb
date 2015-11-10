class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /rounds/:round_id/matches
  # GET /rounds/:round_id/matches.json
  def index
    @round = Round.find params[:round_id]
    @matches = @round.matches
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /rounds/:round_id/matches/new
  def new
    if current_user.admin?
      @round = Round.find params[:round_id]
      @match = @round.matches.new
    else
      msg = { alert: "Only administrators can create or manipulate matches. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /matches/1/edit
  def edit
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, alert: "You are not a site admin. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
      return
    end
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    if current_user.admin?
      respond_to do |format|
        if @match.save
          format.html { redirect_to @match, notice: 'Match was successfully created.' }
          format.json { render :show, status: :created, location: @match }
        else
          @round = @match.round
          format.html { render :new }
          format.json { render json: @match.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate matches. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        @round = @match.round
        format.html { render :new, msg }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @match.update(match_params)
          format.html { redirect_to @match, notice: 'Match was successfully updated.' }
          format.json { render :show, status: :ok, location: @match }
        else
          @round = @match.round
          format.html { render :edit }
          format.json { render json: @match.errors, status: :unprocessable_entity }
        end
      end
    else
      @round = @match.round
      msg = { alert: "Only administrators can create or manipulate matches. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to round_url(@round), msg }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @round = @match.round
    if current_user.admin?
      @match.destroy
      respond_to do |format|
        format.html { redirect_to round_matches_url(@match.round),
                      notice: 'Match was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      msg = { alert: "Only administrators can create or manipulate matches. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to round_url(@round), msg }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:name, :description, :round_id,
                                    :location, :home_team_id, :home_team_lineup_id,
                                    :guest_team_id, :guest_team_lineup_id,
                                    :postponed_date, :result_id)
    end
end
