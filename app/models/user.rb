class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :subscribe_user_to_mailing_list
  after_create :send_welcome_email_to_user

  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end

  def send_welcome_email_to_user
    UserMailer.welcome_email(self).deliver_later
  end
end