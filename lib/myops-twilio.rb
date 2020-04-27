class MyopsTwilio < ::Rails::Railtie
  initializer 'myops.twilio.initialize' do
    require 'my_ops/sms_providers/twilio'
  end
end
