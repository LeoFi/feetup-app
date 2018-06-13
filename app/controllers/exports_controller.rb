class ExportsController < ShopifyApp::AuthenticatedController
  before_action :set_export, only: %i[show edit update destroy]

  helper_method :current_shop
  helper_method :current_domain

  def index; end

  def new
    @export = current_shop.exports.new
  end

  def show; end

  def edit; end

  def create
    @export = current_shop.exports.new(export_params)

    respond_to do |format|
      if @export.save
        format.html { redirect_to @export, notice: 'Export was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @export.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @export.update(export_params)
        format.html { redirect_to @export, notice: 'Export was successfully updated.' }
        format.json { render :show, status: :ok, location: @export }
      else
        format.html { render :edit }
        format.json { render json: @export.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @export.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Export was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trigger
    Exporter.new.run_export(current_shop)
    redirect_to root_url, notice: 'Export was successfully triggered.'
  end

  protected

  def current_domain
    @current_domain ||= ShopifyAPI::Shop.current.domain
  end

  def current_shop
    @current_shop ||= Shop.find_by(shopify_domain: current_domain)
    # @current_shop||= ShopifyAPI::Shop.current
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_export
    @export = current_shop.exports.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def export_params
    params.require(:export).permit(:name, :time)
  end
end
