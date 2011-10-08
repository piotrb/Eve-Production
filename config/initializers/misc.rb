require 'activerecord-import'

if defined? ExceptionNotifier
  Rails.application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[EVE] ",
    :sender_address => %{"Exception Notifier" <error@t-p-l.com>},
    :exception_recipients => %w{piotr.banasik@gmail.com}
end