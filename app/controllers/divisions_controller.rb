class DivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  # GET /tournament/:tournament_id/divisions
  # GET /tournament/:tournament_id/divisions.json
  def index
    # TODO requires @tournament in order to make sense
    @tournament = Tournament.find params[:tournament_id]
    @divisions = @tournament.divisions #.paginate(page: params[:page], per_page: 15)
  end

  # GET /divisions/1
  # GET /divisions/1.json
  def show
  end

  # GET /tournament/:tournament_id/divisions/new
  def new
    if current_user.admin?
      @tournament = Tournament.find params[:tournament_id]
      @division = @tournament.divisions.new
    else
      msg = { alert: "Only administrators can create or manipulate divisions. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /divisions/1/edit
  def edit
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, alert: "You are not a site admin. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
      return
    end
  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(division_params)
    if current_user.admin?
      respond_to do |format|
        if @division.save
          format.html { redirect_to @division, notice: 'Division was successfully created.' }
          format.json { render :show, status: :created, location: @division }
        else
          @tournament = @division.tournament
          format.html { render :new }
          format.json { render json: @division.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate divisions. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        @tournament = @division.tournament
        format.html { render :new, msg }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /divisions/1
  # PATCH/PUT /divisions/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @division.update(division_params)
          format.html { redirect_to @division, notice: 'Division was successfully updated.' }
          format.json { render :show, status: :ok, location: @division }
        else
          @tournament = @division.tournament
          format.html { render :edit }
          format.json { render json: @division.errors, status: :unprocessable_entity }
        end
      end
    else
      @tournament = @division.tournament
      msg = { alert: "Only administrators can create or manipulate divisions. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to tournament_url(@tournament), msg }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @tournament = @division.tournament
    if current_user.admin?
      @division.destroy
      respond_to do |format|
        format.html { redirect_to tournament_url(@tournament), notice: 'Division was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      msg = { alert: "Only administrators can create or manipulate divisions. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to tournament_url(@tournament), msg }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def division_params
      params.require(:division).permit(:name, :image, :description, :tournament_id, team_ids: [])
    end
end
