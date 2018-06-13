class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  has_many :exports

  def orders(params = nil)
    params ||= { status: :any }
    ShopifyAPI::Order.find(:all, params: params)
  end
end
