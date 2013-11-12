class IpaddrsController < ApplicationController
  before_action :set_ipaddr, only: [:show, :edit, :update, :destroy]

  # GET /ipaddrs
  # GET /ipaddrs.json
  def index
    @ipaddrs = Ipaddr.all
  end

  # GET /ipaddrs/1
  # GET /ipaddrs/1.json
  def show
  end

  # GET /ipaddrs/new
  def new
    @ipaddr = Ipaddr.new
  end

  # GET /ipaddrs/1/edit
  def edit
  end

  # POST /ipaddrs
  # POST /ipaddrs.json
  def create
    @ipaddr = Ipaddr.new(ipaddr_params)

    respond_to do |format|
      if @ipaddr.save
        format.html { redirect_to @ipaddr, notice: 'Ipaddr was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ipaddr }
      else
        format.html { render action: 'new' }
        format.json { render json: @ipaddr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ipaddrs/1
  # PATCH/PUT /ipaddrs/1.json
  def update
    respond_to do |format|
      if @ipaddr.update(ipaddr_params)
        format.html { redirect_to @ipaddr, notice: 'Ipaddr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ipaddr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipaddrs/1
  # DELETE /ipaddrs/1.json
  def destroy
    @ipaddr.destroy
    respond_to do |format|
      format.html { redirect_to ipaddrs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipaddr
      @ipaddr = Ipaddr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipaddr_params
      params.require(:ipaddr).permit(:ipaddress, :manageno, :servername, :macaddress, :use, :remarks)
    end
end
