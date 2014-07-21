class IndexWorker
  include Sidekiq::Worker

  # to make things work more dynamically:

  #  IndexWorker.perform_async(3, "MenuItem")
  def perform(id, record_class_name)
    @record = record_class_name.safe_constantize.find(id)
    @record.update_pg_search_document
  end
end

# def perform(menu_item_id)
#   # find the record we want to update
#   # @menu_item = MenuItem.find(menu_item_id)
#   # and update it
#   # @menu_item.update_pg_search_document
# end
