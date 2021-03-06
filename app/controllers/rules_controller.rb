class RulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.paginate(page: params[:page], per_page: 15)
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    if current_user.admin?
      @rule = Rule.new
    else
      respond_to do |format|
        format.html { redirect_to rules_url, alert: "You are not a site admin. Rules can only be updated by admins. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # GET /rules/1/edit
  def edit
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, alert: "You are not a site admin. Rules can only be updated by admins. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
      return
    end
  end

  # POST /rules
  # POST /rules.json
  def create
    if current_user.admin?
      @rule = Rule.new(rule_params)

      respond_to do |format|
        if @rule.save
          format.html { redirect_to @rule, notice: 'Rule was successfully created.' }
          format.json { render :show, status: :created, location: @rule }
        else
          format.html { render :new }
          format.json { render json: @rule.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to rules_url, alert: "You are not a site admin. Rules can only be updated by admins. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @rule.update(rule_params)
          format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
          format.json { render :show, status: :ok, location: @rule }
        else
          format.html { render :edit }
          format.json { render json: @rule.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to rules_url, alert: "You are not a site admin. Rules can only be updated by admins. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    if current_user.admin?
      @rule.destroy
      respond_to do |format|
        format.html { redirect_to rules_url, notice: 'Rule was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to rules_url, alert: "You are not a site admin. Rules can only be updated by admins. Contact #{CHESS_ADMIN_EMAIL}." }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rule_params
    params.require(:rule).permit(:name, :summary, :body)
  end
end
