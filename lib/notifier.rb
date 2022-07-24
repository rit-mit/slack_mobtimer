require 'slack'

module Notifier
  class Slack
    def post_message(comment:)
      client.chat_postMessage(
        text: comment,
        username: username,
        channel: channel
      )
    end

    private

    def client
      ::Slack.configure do |config|
        config.token = ENV['SLACK_TOKEN']
      end

      @client ||= ::Slack::Web::Client.new
    end

    def username
      ENV['SLACK_POST_BOT_NAME']
    end

    def channel
      ENV['SLACK_POST_CHANNEL']
    end
  end
end
