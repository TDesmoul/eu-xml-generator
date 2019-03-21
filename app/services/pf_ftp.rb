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
    FileUtils.mkdir_p(local_directory) unless File.directory?(local_directory)
    @ftp.getbinaryfile(file_name, local_directory + file_name)
    @ftp.close
    puts "#{file_name} téléchargé!"
  end

  def download_xml_base(local_directory, file_name)
    @ftp.chdir("source_xmls")
    file_path = local_directory + file_name
    FileUtils.mkdir_p(local_directory) unless File.directory?(local_directory)
    @ftp.getbinaryfile("base.xml", file_path)
    @ftp.close
    puts "XML base downloaded at #{file_path}"
  end

  def upload_file(ftp_repo, file_path)
    @ftp.chdir(ftp_repo)
    @ftp.putbinaryfile(file_path)
    @ftp.close
    puts "#{file_path} uploadé sur le FTP!"
  end


  def get_files_list(repository)
    puts "Récupération de la liste des fichiers présent dans #{repository}..."
    ftp_root = Rails.env.development? ? "test/" : ""
    repo_path = ["#{ftp_root}csvs", repository].join("/")
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
