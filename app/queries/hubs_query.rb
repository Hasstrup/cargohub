module Queries
  class HubsQuery
    def self.call(arguments)
      new.call(arguments)
    end

    def call
      @search_text = arguments.delete(:search_text)
      @query = arguments.delete(:query)
      @order_by = arguments.delete(:order_by)
      @filter_by = arguments.delete(:filter_by)
      @coordinates = arguments.delete(:coordinates)
      results = Hub
                .search(search_text)
                .where(build_query)
                .order(@order_by[:field] => @order_by[:direction])
    end

    private

      def build_query
        return {} if @filter_by.nil?
      end
  end
end