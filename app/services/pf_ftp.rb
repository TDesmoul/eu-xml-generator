class PfFtp
  require "net/ftp"

  def initialize
    @ftp = Net::FTP.new(ENV["PF_FTP_HOST"])
    @ftp.passive = true if @ftp.login(ENV["PF_FTP_USERNAME"], ENV["PF_FTP_PASSWORD"])
    puts "connexion au FTP réussie"
  end

  def download_file(directory, file_name, file_type)
    @ftp.chdir(directory)
    @ftp.getbinaryfile(file_name, Rails.root + 'lib/xml_files/' + file_name)
    @ftp.close
    puts "le #{file_type} a bien été téléchargé"
  end

  def upload_file(file_name)
    directory = ENV['PF_FTP_DIR_MP_ORDERS']
    file_path = Rails.root + "lib/xml_files/#{file_name}"
    @ftp.chdir(directory)
    @ftp.putbinaryfile(file_path)
    @ftp.close
    puts "#{file_name} uploadé sur le FTP!"
  end
end
