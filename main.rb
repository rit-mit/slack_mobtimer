require 'thor'
require 'dotenv'
require 'pry'

require_relative './lib/mob_timer'

class CliApp < Thor
  desc 'start mobtimer', 'start mobtimer'
  option :members, aliases: 'm', type: :string
  option :interval, aliases: 'i'
  def mobtimer
    Dotenv.load

    mob_members = options[:members].split(',').map(&:strip)
    interval = options[:interval].to_i

    MobTimer.new.start(mob_members: mob_members, interval: interval)
  end
end

CliApp.start(ARGV)
