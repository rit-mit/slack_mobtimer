require 'logger'
require_relative './notifier'

class MobTimer
  def start(mob_members:, interval: 20 * 60)
    logger.info('START mobtimer!')
    logger.info("members: #{mob_members.join}")
    logger.info("interval: #{interval / 60} min")

    members_loop_index = 0

    loop do
      current_member = mob_members[members_loop_index]
      if members_loop_index == mob_members.count - 1
        members_loop_index = 0
      else
        members_loop_index += 1
      end

      notify_member_turn(current_member: current_member)

      sleep(interval)
    end
  end

  private

  def notify_member_turn(current_member:)
    comment = "<@#{current_member}> さんのターン！"
    # notifier.post_message(comment: comment)

    logger.info(comment)
  end

  def notifier
    @notifier ||= Notifier::Slack.new
  end

  def logger
    @logger ||= ::Logger.new($stdout)
  end
end
