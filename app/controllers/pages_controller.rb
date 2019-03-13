class PagesController < ApplicationController
  def home
  end
  def create_xmls
    CreateXmlsJob.perform_now #.set(queue: :critical).perform_later
    flash[:notice] = "les fichiers ont bien été téléchargés sur le FTP"
    redirect_to root_path
  end
end
