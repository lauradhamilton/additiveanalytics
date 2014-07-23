class UnityServersController < ApplicationController
  before_action :set_unity_server, only: [:show, :edit, :update, :destroy]

  # GET /unity_servers
  def index
    @unity_servers = UnityServer.all
  end

  # GET /unity_servers/1
  def show
  end

  # GET /unity_servers/new
  def new
    @unity_server = UnityServer.new
  end

  # GET /unity_servers/1/edit
  def edit
  end

  # POST /unity_servers
  def create
    @unity_server = UnityServer.new(unity_server_params)

    if @unity_server.save
      redirect_to @unity_server, notice: 'Unity server was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /unity_servers/1
  def update
    if @unity_server.update(unity_server_params)
      redirect_to @unity_server, notice: 'Unity server was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /unity_servers/1
  def destroy
    @unity_server.destroy
    redirect_to unity_servers_url, notice: 'Unity server was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_unity_server
    @unity_server = UnityServer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def unity_server_params
    params.require(:unity_server).permit(:server_time_zone, :server_time, :server_date_time_offset, :system, :product_version, :uai_born_on_date)
  end
end
