class SearchResultsController < ApplicationController

  def index
    @results = MenuItem.search(params[:q])
  end

  def location_search_index
    params[:coordinates] = [params[:longitude], params[:latitude]] unless params[:latitude].blank? || params[:longitude].blank?
    @results = Location.search(params)
  end
end
