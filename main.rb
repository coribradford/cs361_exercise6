# Exercise 6

class ParticipantArray
	
	def initialize(email_addresses)
		@email_addresses = email_addresses
	end

	def generate_participant_users_from_email_string
		return if @email_addresses.blank?
		@email_addresses.split.uniq.map do |email_address|
			User.create(email: email_address.downcase, password: Devise.friendly_token)
		end
	end

end

class LaunchDiscussionWorkflow

	def initialize(discussion, host, participants_email_string)
		@discussion = discussion
		@host = host
		@participants = participants
	end
  
	# Expects @participants array to be filled with User objects
	def run
		return unless valid?
		run_callbacks(:create) do
			ActiveRecord::Base.transaction do
				discussion.save!
				create_discussion_roles!
				@successful = true
			end
		end
	end

	# ...
end
  
  
discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
email_addresses = "fake1@example.com\nfake2@example.com\nfake3@example.com"
participants = ParticipantArray.new(email_addresses)

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
workflow.generate_participant_users_from_email_string
workflow.run
  