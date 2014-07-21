# this is how Sidekiq worker is always set up
class FakeWorker
  include Sidekiq::Worker


  def perform
    puts "\n\nRunning a long task"
    # ruby method. waits 30 seconds
    sleep 30
    puts 'Almost done!!!!'
    sleep 2
    puts "Done!!! ZOMG! O_o\n\n"
  end
end
