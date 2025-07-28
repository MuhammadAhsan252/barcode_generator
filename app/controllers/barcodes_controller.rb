require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

class BarcodesController < ApplicationController
  before_action :set_barcode, only: %i[ show edit update destroy print ]

  # GET /barcodes or /barcodes.json
  def index
    @barcodes = Barcode.all
  end

  # GET /barcodes/1 or /barcodes/1.json
  def show
  end

  # GET /barcodes/new
  def new
    @barcode = Barcode.new
  end

  # GET /barcodes/1/edit
  def edit
  end

  # POST /barcodes or /barcodes.json
  def create
    @barcode = Barcode.new(barcode_params)
    respond_to do |format|
      if @barcode.save
        format.html { redirect_to @barcode, notice: "Barcode was successfully created." }
        format.json { render :show, status: :created, location: @barcode }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /barcodes/1 or /barcodes/1.json
  def update
    respond_to do |format|
      if @barcode.update(barcode_params)
        format.html { redirect_to @barcode, notice: "Barcode was successfully updated." }
        format.json { render :show, status: :ok, location: @barcode }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barcodes/1 or /barcodes/1.json
  def destroy
    @barcode.destroy!

    respond_to do |format|
      format.html { redirect_to barcodes_path, status: :see_other, notice: "Barcode was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /barcodes/1/print_barcode
  def print
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barcode
      @barcode = Barcode.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def barcode_params
      params.expect(barcode: [ :name, :value ])
    end
end
