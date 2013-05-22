class MissionControlCommand
  def initialize(cmd)
    @cmd = cmd
  end

  def self.check_in_path
    ENV['HOME'] + '/check_in'
  end

  def time_spent 
  end

  def delete_file
  end

  def output
    time = Time.now.strftime '%l:%M %p'
    if @cmd == 'in'
      if FileTest.exists?(self.class.check_in_path)
        'Already signed in'
      else
        File.open(self.class.check_in_path, 'w') { |f| f.puts time }
        'You are checked in as of ' + time
      end
    elsif @cmd == 'out'
      if FileTest.exists?(self.class.check_in_path) == false
        'Already signed out'
      else
        File.delete(ENV['HOME'] + '/check_in')
        puts 'You are checked out as of ' + time
        puts 'Total time spent ' + time_spent
      end

    end
  end
end
