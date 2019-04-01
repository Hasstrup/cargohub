module TestSupport
  module GraphQlHelper
    def self.included(scope)
      scope.let(:result) do
        res = CargohubSchema.execute(query_string,
                                     context: {},
                                     variables: variables)
        res.to_h.with_indifferent_access
      end
    end
  end
end
