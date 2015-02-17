class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    gb = Gibbon::API.new
    gb.lists.subscribe({:id => ENV["MAILCHIMP_LIST_ID"], :email => {:email => user.email}, :merge_vars => {:FNAME => user.first_name, :LNAME => user.last_name}, :double_optin => false})
  end
end
