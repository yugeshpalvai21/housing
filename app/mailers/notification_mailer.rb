class NotificationMailer < ApplicationMailer
  def send_notification(asset_owner, asset_user)
    @owner = asset_owner
    @user = asset_user
    mail(to: [@owner, @user], subject: 'New Purchase Placed')
  end
end
