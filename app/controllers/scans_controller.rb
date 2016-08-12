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
    params.require(:scan).permit(:event, :result, commit: permit_recursive_params(params[:scan][:commit]))
  end

  # Strong params currently does not permit hashes.
  # This fix was found here https://gist.github.com/koenpunt/ac279e05cfeb0954ca763344fc0240b4#file-permit_recursive_params-rb
  def permit_recursive_params(params)
    (params.try(:to_unsafe_h) || params).map do |key, value|
      if value.is_a?(Array)
        if value.first.respond_to?(:map)
          { key => [ permit_recursive_params(value.first) ] }
        else
          { key => [] }
        end
      elsif value.is_a?(Hash)
        { key => permit_recursive_params(value) }
      else
        key
      end
    end
  end
end
