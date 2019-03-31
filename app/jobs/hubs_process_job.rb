require 'pusher'

# takes in classes in batches and persists them to the database
class HubsProcessJob < ApplicationJob
  queue_as :default

  discard_on ActiveRecord::StatementInvalid

  def perform(batch)
    HubsProcessInteractor.call(batch: batch)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e)
  end
end
