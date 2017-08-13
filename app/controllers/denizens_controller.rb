class DenizensController < ApplicationController
  before_action :set_denizen, only: [:show, :edit, :update, :destroy]

  # GET /denizens
  # GET /denizens.json
  def index
    @denizens = Denizen.all
  end

  # GET /denizens/1
  # GET /denizens/1.json
  def show
  end

  # GET /denizens/new
  def new
    @denizen = Denizen.new
  end

  # GET /denizens/1/edit
  def edit
  end

  def startworker
    require "#{Rails.root}/lib/workers/homeassistantbase.rb"
    Dir["#{Rails.root}/lib/workers/homeassistant/*.rb"].each {|file| require file }
    Delayed::Job.enqueue(EventListener.new())
    flash[:notice] = "Test run successfully created"
    redirect_to root_path
  end

  # POST /denizens
  # POST /denizens.json
  def create
    @denizen = Denizen.new(denizen_params)

    respond_to do |format|
      if @denizen.save
        format.html { redirect_to @denizen, notice: 'Denizen was successfully created.' }
        format.json { render :show, status: :created, location: @denizen }
      else
        format.html { render :new }
        format.json { render json: @denizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /denizens/1
  # PATCH/PUT /denizens/1.json
  def update
    respond_to do |format|
      if @denizen.update(denizen_params)
        format.html { redirect_to @denizen, notice: 'Denizen was successfully updated.' }
        format.json { render :show, status: :ok, location: @denizen }
      else
        format.html { render :edit }
        format.json { render json: @denizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /denizens/1
  # DELETE /denizens/1.json
  def destroy
    @denizen.destroy
    respond_to do |format|
      format.html { redirect_to denizens_url, notice: 'Denizen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_denizen
      @denizen = Denizen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def denizen_params
      params.require(:denizen).permit(:full_name, :nickname)
    end
end
