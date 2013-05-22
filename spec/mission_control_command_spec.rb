require 'rspec'
require 'time'

require_relative '../lib/mission_control_command'

describe MissionControlCommand do

  context 'checking in' do
    it 'acknowledges my check in' do
      cmd = MissionControlCommand.new('in')
      expect(cmd.output).to include('You are checked in')
    end

    it 'creates a check in file' do
      cmd = MissionControlCommand.new('in')
      check_in_path = cmd.class.check_in_path
      if FileTest.exists?(check_in_path)
        FileUtils.rm(check_in_path)
      end
      cmd.output
      expect(check_in_path).to be_true
    end

    it 'cannot sign in if already checked in' do
      cmd = MissionControlCommand.new('in')
      cmd2 = MissionControlCommand.new('in')
      expect(cmd2.output).to include('Already signed in')
    end

    it 'shows time of sign in' do
      cmd = MissionControlCommand.new('in')
      check_in_path = cmd.class.check_in_path
      if FileTest.exists?(check_in_path)
        FileUtils.rm(check_in_path)
      end
      time = Time.now.strftime '%l:%M %p'
      expect(cmd.output).to include(time)
    end
  end

  context 'checking out' do
    it 'acknowledges my check out' do
      cmd = MissionControlCommand.new('out')
      expect(cmd.output).to include('You are checked out')
    end

    it 'removes the file on check out' do
      cmd = MissionControlCommand.new('out')
      check_in_path = cmd.class.check_in_path
      expect(ENV['HOME'].include?(check_in_path)).to be_false
    end

    it 'cannot sign out if already signed out' do
      cmd = MissionControlCommand.new('out')
      cmd2 = MissionControlCommand.new('out')
      expect(cmd2.output).to include('Already signed out')
    end

    it "shouldn't show a time at sign out" do
      cmd = MissionControlCommand.new('out')
      check_in_path = cmd.class.check_in_path
      if FileTest.exists?(check_in_path)
        time = Time.now.strftime '%l:%M %p'
        expect(cmd.output).to_not include(time)
      end

    # it 'shows duration of time spent on sign out'
    #   cmd = MissionControlCommand.new('out')
    #   check_in_path = cmd.class.check_in_path
    #   if FileTest.exists?(check_in_path)
    #     time_spent = Time.now -time_start
    #     expect(cmd.output).to include('Total time spent:')
    #     expect(cmd.output).to include(time_spent)
    # end
    end
  end
end
