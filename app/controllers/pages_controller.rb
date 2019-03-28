class PagesController < ApplicationController
  def home
    missing_ingredient_xml = MissingXml.find_by(xml_type: "ingredient")
    @missing_ingredient_cas = missing_ingredient_xml.elements if missing_ingredient_xml
    missing_emission_xml = MissingXml.find_by(xml_type: "emission")
    @missing_emission_cas = missing_emission_xml.elements if missing_emission_xml
    @job_in_progress = Sidekiq::Workers.new.size > 0
  end
  def check_ingredients_and_emissions
    CheckIngredientsAndEmissionsJob.perform_later
    respond_to do |format|
      format.html do
        redirect_to root_path
      end
      format.js
    end
  end
  def create_xmls
    CheckDatasAndCreateXmlsJob.perform_later #.set(queue: :critical).perform_later
    respond_to do |format|
      format.html do
        redirect_to root_path
      end
      format.js
    end
  end
end
