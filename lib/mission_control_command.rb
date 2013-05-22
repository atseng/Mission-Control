require 'time'

class MissionControlCommand
  def initialize(cmd)
    @cmd = cmd
  end

  def self.check_in_path
    ENV['HOME'] + '/check_in'
  end

  def output
    time = Time.now.strftime '%l:%M %p'
    if @cmd == 'in'
      if FileTest.exists?(self.class.check_in_path)
        'Already signed in'
      else
        File.open(self.class.check_in_path, 'w') { |f| f.puts time }
        'You are checked in as of' + time
      end
    elsif @cmd == 'out'
      if FileTest.exists?(self.class.check_in_path) == false
        'Already signed out'
      else
        file = File.open(ENV['HOME'] + '/check_in', 'rb')
        check_in_time = file.read
        time_spent = Time.now - Time.parse(check_in_time)
        time_spent = (time_spent.to_i / 60).to_s
        File.delete(ENV['HOME'] + '/check_in')
        'You are checked out as of' + time + "\n" + 'Total time spent: ' + time_spent + ' minutes'
      end
    else
      'Not a valid input'
    end
  end
end