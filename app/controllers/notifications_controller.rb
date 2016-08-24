class NotificationsController < ApplicationController
  def index
  end

  def validate_message
    phone_number = params[:phone_number]
    alert_message = params[:alert_message]
    if phone_number.present? && alert_message.present?
      send_message(phone_number, alert_message)
    end

    redirect_to notify_path
  end

  private

  def send_message(phone_number, alert_message)

    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => phone_number,
      :body => alert_message,
      # US phone numbers can make use of an image as well.
      # :media_url => image_url
    )
    puts message.to
  end

end
