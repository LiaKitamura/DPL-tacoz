# whenever you make a concern its a module
module Indexable
  # and extends from ActiveSupport::Concern
  extend ActiveSupport::Concern

  included do
    after_update :update_search_index
  end

  def update_search_index
    IndexWorker.perform_async(self.id, self.class.name)
  end
end
