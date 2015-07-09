class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.paginate(page: params[:page], per_page: 15)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    # TODO check if team member is captain
  end

  # POST /teams
  # POST /teams.json
  def create
    # TODO creating a team makes you captain
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    # TODO check if team member is captain
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    # TODO maybe we allow captains to remove teams if there is no results associated?
    msg = {}
    current_captain = @team.captains.include? current_user.player
    if current_captain and @team.players < 1
      if @team.destroy
        msg[:notice] = "Successfully removed team!"
      else
        # TODO admin email here
        msg[:alert] = "Failed to remove team. Contact your administrator."
      end
    else
      msg[:alert] = "Failed to remove team. "
      msg[:alert] << "Only captains can remove teams." unless current_captain
      msg[:alert] << "Must remove all players first." unless @team.players < 1
    end
    respond_to do |format|
      format.html { redirect_to teams_url, alert: 'Teams cannot be removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :image)
    end
end
