class SiteController < ApplicationController

  def index

  end

  def about

  end

  def contact

  end

  def contact_submit
    # ContactWorker.perform_async(params[:name], params[:email], params[:subject], params[:question])
    # if you use this built in ContactMailer.delay...sidekiq has the worker built in so you don't need to build one
    ContactMailer.delay.contact_request(params)
    redirect_to root_path, notice: 'Thanks for contacting us!'
  end
end
