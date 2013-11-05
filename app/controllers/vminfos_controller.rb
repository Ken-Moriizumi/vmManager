class VminfosController < ApplicationController
  before_action :set_vminfo, only: [:show, :edit, :update, :destroy]

  # GET /vminfos
  # GET /vminfos.json
  def index
    #@vminfos = Vminfo.all
    myDc = Mydatacenter.new
    @vminfos = myDc.vmArray 
  end

  def poweron
    myDc = Mydatacenter.new
    vm = myDc.search_vm_by_name(params[:name])
    vm.powerOn
    redirect_to :action => 'index'
  end

  def poweroff
    myDc = Mydatacenter.new
    vm = myDc.search_vm_by_name(params[:name])
    vm.powerOff
    redirect_to :action => 'index'
  end

  def migrate
    myDc = Mydatacenter.new
    @vminfos = myDc.vmArray 
    @vminfo = myDc.search_vm_by_name(params[:name])
  end

  def clone
    CloneWorker.perform_async(params[:vminfo][:name], 
                              "dev" + params[:newInfo][:cloneName],
                              params[:newInfo][:ipaddr],
                              params[:newInfo][:jsnn],
                              params[:newInfo][:jsc])
    #SshWorker.perform_async(params[:newInfo][:cloneName],params[:newInfo][:ipaddr],params[:newInfo][:jsnn],params[:newInfo][:jsc])
    redirect_to :action => 'index'
  end

  def reconfig_edit
    myDc = Mydatacenter.new
    @vminfos = myDc.vmArray 
    @vminfo = myDc.search_vm_by_name(params[:name])
    @cpu_Select = {"1" => 1, "2" => 2, "4" => 4}
    @mem_Select = {"512" => 512,"1024" => 1024,"2048" => 2048,"4096" => 4096}
  end
  
  def reconfig
    myDc = Mydatacenter.new
    @vminfo = myDc.search_vm_by_name(params[:vmname])
    @vminfo.powerOff if @vminfo.powerstatus != "poweredOff"
    @vminfo.reconfig_cpuname_to(params[:cpunum])
    @vminfo.reconfig_memsize_to(params[:memsize])
    redirect_to :action => 'index'
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
