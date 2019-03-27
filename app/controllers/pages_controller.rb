class PagesController < ApplicationController
  def home
    @missing_xmls = MissingXml.all
  end
  def create_xmls
    CreateXmlsJob.perform_later #.set(queue: :critical).perform_later
    flash[:notice] = "La génération des fichiers a bien été lancée!"
    redirect_to root_path
  end
  def job_in_progress
    @missing_xmls = MissingXml.all
    @job_in_progress = Sidekiq::Workers.new.size > 0
    render :home
  end
end
