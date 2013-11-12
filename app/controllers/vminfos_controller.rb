class VminfosController < ApplicationController
  before_action :set_vminfo #, only: [:show, :edit, :update, :destroy]

  # GET /vminfos
  # GET /vminfos.json
  def index
  end
 
  def templates
  end

  def poweron
    @vminfo.powerOn
    redirect_to :action => 'index'
  end

  def poweroff
    @vminfo.powerOff
    redirect_to :action => 'index'
  end

  def migrate
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
    @cpu_Select = {"1" => 1, "2" => 2, "4" => 4}
    @mem_Select = {"512" => 512,"1024" => 1024,"2048" => 2048,"4096" => 4096}
  end
  
  def reconfig
    @vminfo.powerOff if @vminfo.powerstatus != "poweredOff"
    @vminfo.reconfig_cpuname_to(params[:cpunum])
    @vminfo.reconfig_memsize_to(params[:memsize])
    redirect_to :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vminfo
      myDc = Mydatacenter.new
      @vminfos = myDc.vmArray 
      @vminfo = myDc.search_vm_by_name(params[:name])
      #@vminfo = Vminfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vminfo_params
      params.require(:vminfo).permit(:name, :path, :ipaddress)
    end
end
