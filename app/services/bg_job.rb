class BgJob
  require 'sidekiq/api'

  def self.finished?
    Sidekiq::Workers.new.size == 0
  end
end
