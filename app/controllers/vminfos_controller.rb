class VminfosController < ApplicationController
  before_action :set_vminfo, only: [:show, :edit, :update, :destroy]

  # GET /vminfos
  # GET /vminfos.json
  def index
    #@vminfos = Vminfo.all
    myDc = Mydatacenter.new
    @vminfos = myDc.vmArray 
  end

  # GET /vminfos/1
  # GET /vminfos/1.json
  def show
  end

  # GET /vminfos/new
  def new
    @vminfo = Vminfo.new
  end

  # GET /vminfos/1/edit
  def edit
  end

  # POST /vminfos
  # POST /vminfos.json
  def create
    @vminfo = Vminfo.new(vminfo_params)

    respond_to do |format|
      if @vminfo.save
        format.html { redirect_to @vminfo, notice: 'Vminfo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vminfo }
      else
        format.html { render action: 'new' }
        format.json { render json: @vminfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vminfos/1
  # PATCH/PUT /vminfos/1.json
  def update
    respond_to do |format|
      if @vminfo.update(vminfo_params)
        format.html { redirect_to @vminfo, notice: 'Vminfo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vminfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vminfos/1
  # DELETE /vminfos/1.json
  def destroy
    @vminfo.destroy
    respond_to do |format|
      format.html { redirect_to vminfos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vminfo
      @vminfo = Vminfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vminfo_params
      params.require(:vminfo).permit(:name, :path, :ipaddress)
    end
end