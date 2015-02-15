Gibbon::API.api_key = ENV["MAILCHIMP_API_KEY"]
puts "API KEY: #{Gibbon::API.api_key}"
Gibbon::API.timeout = 15
Gibbon::API.throws_exceptions = false