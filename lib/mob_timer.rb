require 'logger'
require_relative './notifier'

class MobTimer
  PRE_NOTIFY_SEC = 2 * 60

  def start(mob_members:, interval: 20 * 60, randomize: false, pre_notify: PRE_NOTIFY_SEC)
    logger.info('START mobtimer!')
    logger.info("members: #{mob_members.join}")
    logger.info("interval: #{interval / 60} min")
    logger.info("randomize: #{randomize}")

    mob_members.shuffle! if randomize
    members_list = build_members_list(mob_members)

    members_list.each.with_index do |current_member, i|
      notify_member_turn(current_member: current_member)
      sleep(interval - pre_notify)

      next_member = members_list[i + 1]
      pre_notify_member_turn(next_member: next_member)

      sleep(pre_notify)
    end
  end

  private

  def build_members_list(mob_members)
    [].tap do |results|
      100.times.each do
        mob_members.each do |m|
          results.push m
        end
      end
    end
  end

  def pre_notify_member_turn(next_member:)
    comment = "もうすぐ <@#{next_member}> さんのターンです"
    notifier.post_message(comment: comment)

    logger.info(comment)
  end

  def notify_member_turn(current_member:)
    comment = "<@#{current_member}> さんのターン！"
    notifier.post_message(comment: comment)

    logger.info(comment)
  end

  def notifier
    @notifier ||= Notifier::Slack.new
  end

  def logger
    @logger ||= ::Logger.new($stdout)
  end
end
