require 'thor'
require 'dotenv'
require 'pry'

require_relative './lib/mob_timer'

class CliApp < Thor
  desc 'start mobtimer', 'start mobtimer'
  option :members, aliases: 'm', type: :string
  option :interval, aliases: 'i'
  option :random, aliases: 'r', type: :boolean, default: false
  def mobtimer
    Dotenv.load

    mob_members = options[:members].split(',').map(&:strip)
    interval = options[:interval].to_i
    randomize = options[:random] || false

    MobTimer.new.start(mob_members: mob_members, interval: interval, randomize: randomize)
  end
end

CliApp.start(ARGV)
