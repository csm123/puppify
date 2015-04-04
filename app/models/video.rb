class Video < ActiveRecord::Base
  belongs_to :category
  after_create :notify_subscribers

  def notify_subscribers
    SendNewVideoInCategoryNotificationEmailsJob.perform_later(self)
  end
end
