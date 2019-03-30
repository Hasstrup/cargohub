# gets all the hubs
class HubsQuery
    def self.call(input)
      new.call(input)
    end

    def call(input)
      prepare_query_values(input)
      scope = Hub.includes(:country).all
      scope = scope.search(@search_text) unless @search_text.nil?
      scope = with_query(scope)
      @order_by.nil? ? scope : scope.order_by(@order_by[:field] => @order_by[:direction])
    end

    private

    def with_query(scope)
      return scope if @query.nil?
      function_string = @query.delete(:function)
      scope = scope.where(@query.compact)
      return scope if function_string.nil?
      scope.where('function LIKE ?', "%#{function_string}%")
    end

    def prepare_query_values(input)
      @search_text = input.delete(:search_text)
      @query = input.delete(:query)
      @order_by = input.delete(:order_by)
      @coordinates = input.delete(:coordinates)
    end
  end
