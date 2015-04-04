class SendNewVideoInCategoryNotificationEmailsJob < ActiveJob::Base
  queue_as :default

  require "mandrill"

  def perform(video)
    category = video.category
    subscribers = category.subscriptions.pluck(:user_id)

    if subscribers.count > 0
      recipients = convert_users_to_mandrill_recipients(subscribers)
      merge_vars = convert_users_to_mandrill_merge_fields(subscribers)
      body = ActionController::Base.new.
        render_to_string("user_mailer/new_video_in_category_notification_email.html.erb", 
        :layout => false)

      m = Mandrill::API.new
      message = {
        :from_name=> "Puppify",
        :from_email=>"puppify@puppify.com",
        :to=> recipients,   
        :subject=> "New in #{category.name}: #{video.title}",  
        :html=> body,  
        :merge_vars => merge_vars,
        :preserve_recipients => false,
        :global_merge_vars => [
          {name: "category", content: category.name}, 
          {name: "video_title", content: video.title}, 
          {name: "video_url", content: Rails.application.routes.url_helpers.video_path(video)}
        ]
      }  
      m.messages.send message
    end
  end

  def convert_users_to_mandrill_recipients(user_ids)
    user_ids.map do |user_id|
      user = User.find(user_id)
      {:email => user.email}
    end
  end

  def convert_users_to_mandrill_merge_fields(user_ids)
    user_ids.map do |user_id| 
      user = User.find(user_id)
      {:rcpt => user.email, :vars => [{:name => "first_name", :content => user.first_name}]}
    end
  end

end