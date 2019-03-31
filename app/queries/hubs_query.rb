# gets all the hubs
class HubsQuery
  def self.call(input)
    new.call(input)
  end

  def call(input)
    return Hub.all if input.empty?
    prepare_query_values(input)
    scope = Hub.includes(:country).all
    scope = scope.search(@search_text) unless @search_text.nil?
    scope = with_query(scope)
    @order_by.nil? ? scope : scope.order(@order_by[:field] => @order_by[:direction])
  end

  private

  def with_query(scope)
    return scope if @query.nil?
    query = @query.to_h
    function_string = query.delete(:function)
    address = query.delete(:address)
    scope = scope.where(query.compact)
    scope = scope.near(address) unless address.nil?
    return scope if function_string.nil?
    scope.where('function LIKE ?', "%#{function_string}%")
  end

  def prepare_query_values(input)
    @search_text = input.delete(:search_text)
    @query = input.delete(:query)
    @order_by = input.delete(:order_by)
  end
end
