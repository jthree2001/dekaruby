class ElementsController < ApplicationController
  before_action :set_element, only: [:show, :edit, :update, :destroy]

  # GET /elements
  # GET /elements.json
  def index
    @elements = Element.all
  end

  # GET /elements/1
  # GET /elements/1.json
  def show
  end

  # GET /elements/new
  def new
    @element = Element.new
  end

  # GET /elements/1/edit
  def edit
  end

  # POST /elements
  # POST /elements.json
  def create
    @element = Element.new(element_params)

    respond_to do |format|
      if @element.save
        format.html { redirect_to @element, notice: 'Element was successfully created.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { render :new }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elements/1
  # PATCH/PUT /elements/1.json
  def update
    respond_to do |format|
      if @element.update(element_params)
        format.html { redirect_to @element, notice: 'Element was successfully updated.' }
        format.json { render :show, status: :ok, location: @element }
      else
        format.html { render :edit }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elements/1
  # DELETE /elements/1.json
  def destroy
    @element.destroy
    respond_to do |format|
      format.html { redirect_to elements_url, notice: 'Element was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = Element.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def element_params
      params.require(:element).permit(:entity_id, :friendly_name, :location, :denizen_id, :state)
    end
end
