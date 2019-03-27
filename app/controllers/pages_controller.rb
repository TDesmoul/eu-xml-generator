class PagesController < ApplicationController
  def home
    @missing_xmls = MissingXml.all
    @job_in_progress = Sidekiq::Workers.new.size > 0
  end
  def create_xmls
    CheckDatasAndCreateXmlsJob.perform_later #.set(queue: :critical).perform_later
    flash[:notice] = "Après vérification des données, la génération des fichiers a bien été lancée!"
    redirect_to root_path
  end
  def job_in_progress
    @missing_xmls = MissingXml.all
    @job_in_progress = Sidekiq::Workers.new.size > 0
    respond_to do |format|
      format.html do
        render :home
      end
      format.js
    end
  end
end
