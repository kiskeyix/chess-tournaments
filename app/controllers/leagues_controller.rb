class LeaguesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
  end

  # GET /leagues/new
  def new
    if current_user.admin?
      @league = League.new
    else
      msg = { alert: "Only administrators can create or manipulate leagues. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /leagues/1/edit
  def edit
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, alert: "You are not a site admin. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
      return
    end
  end

  # POST /leagues
  # POST /leagues.json
  def create
    if current_user.admin?
      @league = League.new(league_params)

      respond_to do |format|
        if @league.save
          format.html { redirect_to @league, notice: 'League was successfully created.' }
          format.json { render :show, status: :created, location: @league }
        else
          format.html { render :new }
          format.json { render json: @league.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate leagues. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @league.update(league_params)
          format.html { redirect_to @league, notice: 'League was successfully updated.' }
          format.json { render :show, status: :ok, location: @league }
        else
          format.html { render :edit }
          format.json { render json: @league.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate leagues. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    if current_user.admin?
      @league.destroy
      respond_to do |format|
        format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      msg = { alert: "Only administrators can create or manipulate leagues. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name, :image, :description, rule_ids: [])
    end
end
