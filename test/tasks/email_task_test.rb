# require "test_helper"
# require "rake"

# class EmailTaskTest < ActiveSupport::TestCase
#   include ActiveJob::TestHelper

#   setup do
#     # Load Rake environment
#     Rake.application.rake_require "tasks/email_guests"
#     Rake::Task.define_task(:environment)

#     # Clear out tasks to avoid duplication issues
#     Rake::Task["email:send_info_to_guests"].reenable

#     # Clear jobs for a clean slate
#     ActiveJob::Base.queue_adapter.enqueued_jobs = []
#   end

#   test "send_info_to_guests task sends email to all rsvp'd guests with emails" do
#     guests_that_should_receive_info = guests.select do |g|
#       g.party.rsvp && g.email.present?
#     end

#     # There should be 3 guests that meet the criteria: Nick, Marnie, Kermit
#     assert_equal 3, guests_that_should_receive_info.count

#     # Check that the mailers are enqueued
#     assert_difference -> { ActiveJob::Base.queue_adapter.enqueued_jobs.size }, guests_that_should_receive_info.count do
#       Rake.application.invoke_task "email:send_info_to_guests"
#     end

#     perform_enqueued_jobs

#     assert_equal ActionMailer::Base.deliveries.size, guests_that_should_receive_info.count
#   end
# end
