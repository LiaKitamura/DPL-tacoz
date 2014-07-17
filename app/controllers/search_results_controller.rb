class SearchResultsController < ApplicationController

  def index
    @results = MenuItem.search(params[:q])
  end
end
