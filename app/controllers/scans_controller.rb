class ScansController < ApplicationController
  http_basic_authenticate_with name: ENV['PERFUSER'], password: ENV['PERFPASS']
  before_action :set_scan, only: [:show, :update, :destroy]

  # GET /scans
  def index
    @scans = Scan.all

    render json: @scans
  end

  # GET /scans/1
  def show
    render json: @scan
  end

  # POST /scans
  def create
    @scan = Scan.new(scan_params)

    if @scan.save
      render json: @scan, status: :created, location: @scan
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scans/1
  def update
    if @scan.update(scan_params)
      render json: @scan
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scans/1
  def destroy
    @scan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scan_params
      params.require(:scan).permit!
    end
end
