require 'httparty'
require 'uri'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
	# message.mark_seen
	# message.typing_on

	# via http://stackoverflow.com/a/3809435
	http_less_url = /[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/

	p message

	message_text = message.text.strip

	begin

		if message.respond_to? :typing_on
			message.typing_on
		else
			message.type
		end

		if message_text.downcase == 'hi' || message_text.downcase == 'hello' || message_text.downcase == 'hey'
			message.reply(text: "Hey there. Send me a URL to update its Facebook info.")
		elsif message_text =~ URI.regexp
			# update
			fb_update_successful = facebook_update(message_text)
			if fb_update_successful
				message.reply(text: "Successfully updated Facebook info for #{fb_update_successful}")
			else
				message.reply(text: "Oops, something went wrong. Please try again.")
			end
		elsif message_text =~ http_less_url
			# request http
			message.reply(text: 'Please make sure your URL starts with http or https.')
		else
			message.reply(text: 'Send me a URL to update its Facebook info.')
		end

	rescue => error

		p error
		message.reply(text: "Oops, something went wrong. Please try again.")

	end

end



def facebook_update(url)

	# https://developers.facebook.com/docs/sharing/opengraph/using-objects
	escaped_url = URI.escape(url)
	fb_url = "https://graph.facebook.com/?id=#{escaped_url}&scrape=true"
	response = HTTParty.post(fb_url)

	if response.code == 200
		body = JSON.parse(response.body)
		title = body["title"]
		if !title.nil?
			return "your page: #{title}."
		else
			return "your page."
		end
	else
		return false
	end

end