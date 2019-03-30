# takes in classes in batches and persists them to the database
class HubsProcessJob < ApplicationJob
  def perfrom(batch)
    HubsProcessInteractor.call(batch: batch)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e)
  end
end
