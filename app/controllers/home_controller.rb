class HomeController < ApplicationController
  def index
    render plain: "Not found", status: 404
  end

  def not_found
    render plain: "Not found", status: 404
  end

  def method_not_found
    render plain: "Not found", status: 405
  end
end
