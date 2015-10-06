class TournamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.paginate(page: params[:page], per_page: 15)
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    if current_user.admin?
      @tournament = Tournament.new
    else
      msg = { alert: "Only administrators can create or manipulate tournaments. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    if current_user.admin?
      @tournament = Tournament.new(tournament_params)

      respond_to do |format|
        if @tournament.save
          if @tournament.divisions.size < 1
            begin
              logger.info "#{self.class}.#{__method__} Adding default division"
              @tournament.divisions.create name: "A"
              @tournament.save
              logger.info "#{self.class}.#{__method__} done Adding default division"
            rescue => e
              logger.error "#{self.class}.#{__method__} #{e.class} #{e.message} #{e.backtrace.join(', ')}"
            end
          end
          format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
          format.json { render :show, status: :created, location: @tournament }
        else
          format.html { render :new }
          format.json { render json: @tournament.errors, status: :unprocessable_entity }
        end
      end
    else
      msg = { alert: "Only administrators can create or manipulate tournaments. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    if current_user.admin?
      @tournament.destroy
      respond_to do |format|
        format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      msg = { alert: "Only administrators can create or manipulate tournaments. Contact site administrator #{CHESS_ADMIN_EMAIL}" }
      respond_to do |format|
        format.html { redirect_to root_path, msg }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :image, :description, :league_id, :start_date, :end_date)
    end
end
