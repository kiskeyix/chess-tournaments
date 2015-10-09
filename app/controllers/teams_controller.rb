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
        @team.transaction do
          if @team.players << current_user.player and
            @team.team_captains.create(player_id: current_user.player.id)
            msg = { notice: 'Team was successfully created.' }
          else
            msg = { alert: "Team was successfully created but you were not assigned as captain. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
          end
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
    pri_user = @team.captains.include?(current_user.player) || current_user.admin?
    logger.info "#{__method__}: user #{current_user.id} (admin=#{current_user.admin?}) is priviledged? #{pri_user}"
    respond_to do |format|
      # Note we do not allow creating records for players, this is only to display a message
      # to educate the user(s)
      if pri_user and @team.update(team_params)
        msg = "Note that players cannot be added if they do not exist!"
        format.html { redirect_to @team, notice: "Team was successfully updated. #{msg}" }
        format.json { render :show, status: :ok, location: @team }
      else
        msg[:alert] = 'Only captains can perform this action.'
        if team_params[:player_ids]
          format.html { redirect_to @team, msg }
        else
          format.html { redirect_to edit_team_path(@team), msg }
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
    pri_user = @team.captains.include?(current_user.player) || current_user.admin?
    if pri_user and @team.players.size <= 1
      if @team.destroy
        msg[:notice] = "Successfully removed team!"
      else
        msg[:alert] = "Failed to remove team. Contact your administrator #{CHESS_ADMIN_EMAIL}."
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

  # DELETE /teams/1/remove_captain?captain_id=1
  # DELETE /teams/1/remove_captain.json?captain_id=1
  def remove_captain
    msg = {}
    current_captain = false
    captain = nil
    if params[:captain_id]
      captain = Player.find params[:captain_id]
      logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) removing captain #{params[:captain_id]} from team #{@team.id}"
      current_captain = @team.captains.include? current_user.player
      # you can remove captains if:
      # 1. you're site admin
      # 2. you're a captain
      # 3. you're not removing self
      # 4. number of captains is more than 1
      # 5. validations work
      if current_user.admin? || (@team.captains.size > 1 and current_captain and current_user.player != captain)
        if @team.captains.delete captain
          respond_to do |format|
            format.html { redirect_to @team, notice: "#{captain.name.humanize} is no longer captain of #{@team.name.humanize} Team." }
            format.json { render :show, status: :ok, location: @team }
          end
          logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) removed captain #{params[:captain_id]} from team #{@team.id}"
          return
        end
      end
    else
      msg = { notice: 'Missing parameter captain_id' }
    end
    msg[:alert] = 'You cannot remove self!' if current_user.player == captain and not current_user.admin?
    msg[:alert] = 'You cannot remove captains!' unless current_captain or current_user.admin?
    respond_to do |format|
      format.html { redirect_to @team, msg }
      format.json { head :no_content }
    end
  end

  # POST /teams/1/make_captain?captain_id=1
  # POST /teams/1/make_captain.json?captain_id=1
  def make_captain
    msg = {}
    current_captain = false
    captain = nil
    if params[:captain_id]
      captain = Player.find params[:captain_id]
      logger.info "#{__method__}: User #{current_user.full_name} (#{current_user.id}) adding captain #{params[:captain_id]} to team #{@team.id}"
      current_captain = @team.captains.include? current_user.player
      # you can add captains if:
      # 1. you're site admin
      # 2. you're a captain
      # 3. validations work
      if current_user.admin? or current_captain
        @team.captains << captain
        respond_to do |format|
          format.html { redirect_to @team, notice: "#{captain.name.humanize} is now captain of #{@team.name.humanize} Team." }
          format.json { render :show, status: :ok, location: @team }
        end
        logger.info "#{__method__}: User #{current_user.full_name} (user.id=#{current_user.id}) added captain captain_id=#{params[:captain_id]} to team.id=#{@team.id}"
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

  # GET /teams/:team_id/join_tournaments
  def join_tournaments
    @team = Team.includes(:divisions).find(params[:team_id])
    @tournaments = Division.open_tournaments_without_team(@team)
    #.collect { |div| div.tournament }.uniq
  end


  # PATCH /teams/:team_id/join_divisions
  def join_divisions
    msg = {}
    @team = Team.includes(:divisions).find(params[:team_id])
    if @team.captains.include? current_user.player or current_user.admin?
      begin
        @team.transaction do
          params[:team][:division_ids].each do |id|
            division = Division.find id
            # raise ActiveRecord::Rollback # this is caught for us but we need to change the message to the user
            raise ActiveRecord::ActiveRecordError if division.nil? or
              division.tournament.teams.include? @team
            next if @team.divisions.include? division
            @team.divisions << division
          end
        end
        msg[:notice] = "Your team joined tournaments successfully!"
      rescue ActiveRecord::ActiveRecordError => e
        logger.error "#{__method__}: team #{@team.name} cannot join tournament because #{e.message}"
        msg[:alert] = "Teams cannot join tournaments on different divisions or join more than once on same division."
      end
      respond_to do |format|
        format.html { redirect_to @team, msg }
        format.json { render :show, status: :ok, location: @team }
      end
    else
      msg[:alert] = 'You cannot join tournaments. Contact your team captain.'
      respond_to do |format|
        format.html { redirect_to @team, msg }
        format.json { head :no_content }
      end
    end
  end

  # PATCH /teams/:team_id/add_player
  def add_player
    msg = {}
    @team = Team.find(params[:team_id])
    if @team.captains.include?( current_user.player ) or current_user.admin?
      begin
        players = []
        @team.transaction do
          params[:team][:player_ids].each do |id|
            logger.info "#{__method__}: searching for player=#{id}"
            player = Player.find id
            raise ActiveRecord::ActiveRecordError if player.nil?
            next if @team.players.include? player
            logger.info "#{__method__}: adding player=#{id} to team=#{@team.id}"
            @team.players << player
            players << player
          end
        end
        msg[:notice] = "#{players.collect { |p| p.name }.join(',')} successfully added to team #{@team.name}!"
      rescue ActiveRecord::ActiveRecordError => e
        logger.error "#{__method__}: player could not be added to team #{@team.name} because #{e.message}"
        msg[:alert] = "Could not add player. Contact site administrator"
      end
      respond_to do |format|
        format.html { redirect_to @team, msg }
        format.json { render :show, status: :ok, location: @team }
      end
    else
      msg[:alert] = 'You cannot add players. Contact your team captain.'
      respond_to do |format|
        format.html { redirect_to @team, msg }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :image, player_ids: [],
                                   division_ids: [],
                                   players_attributes: [:id, :name, :_destroy])
    end
end
