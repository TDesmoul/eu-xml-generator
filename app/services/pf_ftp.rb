class PfFtp
  attr_reader :ftp
  require "net/ftp"

  def initialize
    @ftp = Net::FTP.new(ENV["PF_FTP_HOST"])
    @ftp.passive = true if @ftp.login(ENV["PF_FTP_USERNAME"], ENV["PF_FTP_PASSWORD"])
    puts "connexion au FTP réussie"
  end

  def download_file(ftp_directory, local_directory, file_name)
    @ftp.chdir(ftp_directory)
    @ftp.getbinaryfile(file_name, local_directory + file_name)
    @ftp.close
    puts "#{file_name} téléchargé!"
  end

  def download_xml_base(new_file_name)
    @ftp.chdir("source_xmls")
    @ftp.getbinaryfile("base.xml", Rails.root + "lib/xml_files/#{new_file_name}")
    @ftp.close
    puts "XML base downloaded and saved as #{new_file_name}"
  end

  def upload_file(file_name)
    directory = ENV['PF_FTP_DIR_MP_ORDERS']
    file_path = Rails.root + "lib/xml_files/#{file_name}"
    @ftp.chdir(directory)
    @ftp.putbinaryfile(file_path)
    @ftp.close
    puts "#{file_name} uploadé sur le FTP!"
  end


  def get_files_list(repository)
    puts "Récupération de la liste des fichiers présent dans #{repository}..."
    repo_path = ["csvs", repository].join("/")
    @ftp.chdir(repo_path)
    files = @ftp.nlst()
    @ftp.close
    { repo: repo_path, list: files }
  end

  # def download_tracking_infos_files(arg = {})
  #   puts "Récupération des fichiers de tracking depuis le FTP..."
  #   directory = "#{ENV['PF_FTP_DIR_TRACKING_SOURCE']}#{"/test" if arg[:dir] == "test"}"
  #   @ftp.chdir(directory)
  #   files = @ftp.nlst() - ["test"]
  #   files.each do |file_name|
  #     file_path = Rails.root + 'lib/csv_files/' + file_name
  #     @ftp.getbinaryfile(file_name, file_path)
  #   end
  #   @ftp.close
  #   puts "#{files.count} fichiers ont été récupérés sur le FTP : #{files}"
  #   files
  # end
end
