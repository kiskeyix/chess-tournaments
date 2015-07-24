class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy, :remove_captain, :make_captain]

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
    if current_user.player.nil?
      msg = { alert: "Only players can create or manipulate teams. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { render :new, msg }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
      return
    end
    # TODO creating a team makes you captain and player
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        msg = {}
        if @team.players << current_user.player and
          @team.team_captains.create(player_id: current_user.player.id)
          msg = { notice: 'Team was successfully created.' }
        else
          msg = { alert: "Team was successfully created but you were not assigned as captain. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
        end
        format.html { redirect_to @team, msg }
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
    msg = {}
    current_captain = @team.captains.include? current_user.player
    respond_to do |format|
      # Note we do not allow creating records for players, this is only to display a message
      # to educate the user(s)
      if current_captain and @team.update(team_params)
        msg = "Note that players cannot be added if they do not exist!"
        format.html { redirect_to @team, notice: "Team was successfully updated. #{msg}" }
        format.json { render :show, status: :ok, location: @team }
      else
        if team_params[:player_ids]
          format.html { render :show }
        else
          format.html { render :edit }
        end
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
    if current_captain and @team.players <= 1
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
      format.html { redirect_to teams_url, msg }
      format.json { head :no_content }
    end
  end

  # GET /teams/1/remove_captain?captain_id=1
  # GET /teams/1/remove_captain.json?captain_id=1
  # TODO these are use GET instead of DELETE because I couldn't make it work
  def remove_captain
    msg = {}
    current_captain = false
    captain = nil
    if params[:captain_id]
      captain = Player.find params[:captain_id]
      logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) removing captain #{params[:captain_id]} from team #{@team.id}"
      current_captain = @team.captains.include? current_user.player
      # you can remove captains if:
      # 1. you're a captain
      # 2. you're not removing self
      # 3. number of captains is more than 1
      # 4. validations work
      if @team.captains.size > 1 and
        current_captain and
        current_user.player != captain and
        @team.captains.delete captain
        respond_to do |format|
          format.html { redirect_to @team, notice: "#{captain.name.humanize} is no longer captain of #{@team.name.humanize} Team." }
          format.json { render :show, status: :ok, location: @team }
        end
        logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) removed captain #{params[:captain_id]} from team #{@team.id}"
        return
      end
    else
      msg = { notice: 'Missing parameter captain_id' }
    end
    msg[:alert] = 'You cannot remove self!' if current_user.player == captain
    msg[:alert] = 'You cannot remove captains!' unless current_captain
    respond_to do |format|
      format.html { redirect_to @team, msg }
      format.json { head :no_content }
    end
  end

  # GET /teams/1/make_captain?captain_id=1
  # GET /teams/1/make_captain.json?captain_id=1
  # TODO these are use GET instead of POST|PATCH because I couldn't make it work
  def make_captain
    msg = {}
    current_captain = false
    captain = nil
    if params[:captain_id]
      captain = Player.find params[:captain_id]
      logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) adding captain #{params[:captain_id]} to team #{@team.id}"
      current_captain = @team.captains.include? current_user.player
      # you can add captains if:
      # 1. you're a captain
      # 2. validations work
      if current_captain
        @team.captains << captain
        respond_to do |format|
          format.html { redirect_to @team, notice: "#{captain.name.humanize} is now captain of #{@team.name.humanize} Team." }
          format.json { render :show, status: :ok, location: @team }
        end
        logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) added captain #{params[:captain_id]} to team #{@team.id}"
        return
      end
    else
      msg = { notice: 'Missing parameter captain_id' }
    end
    msg[:alert] = 'You cannot add captains!' unless current_captain
    respond_to do |format|
      format.html { redirect_to @team, msg }
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
      params.require(:team).permit(:name, :image, :division_id, player_ids: [],
                                   players_attributes: [:id, :name, :_destroy])
    end
end
