require 'my_ops/sms_provider'
require 'nifty/utils/http'

module MyOps
  module SMSProviders
    class Twilio < MyOps::SMSProvider

      self.provider_name = "Twilio"
      self.provider_description = "Send alert SMS messages using the Twilio service"

      def send_message(recipient, message)
        recipient = recipient.to_s

        if recipient =~ /\A0[1-9]/
          # Add +44 to any numbers provided with a single 0 at the start
          recipient = '+44' + recipient.sub(/\A0/, '')
        end

        self.class.logger.info "Sending to '#{recipient}' with message '#{message}'"
        response = Nifty::Utils::HTTP.post("https://api.twilio.com/2010-04-01/Accounts/#{self.class.config.account_sid}/Messages.json",
          :params => {
            'Body' => message,
            'To' => recipient,
            'MessagingServiceSid' => self.class.config.messaging_service_sid
          },
          :username => self.class.config.account_sid,
          :password => self.class.config.auth_token
        )

        if response[:code] == 201
          self.class.logger.debug "Successfully sent message to #{recipient}".green
          true
        else
          self.class.logger.fatal "Couldn't send message to #{recipient}. API returned #{response[:code]} status. (#{response.inspect})".red
          false
        end
      end

      def self.config
        MyOps.module_config["myops-twilio"]
      end

      def self.logger
        @logger ||= MyOps.logger_for(:twilio)
      end

    end
  end
end
