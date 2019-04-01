import gql from "graphql-tag";

export const countriesQuery = gql`
  query {
    countries {
      edges {
        node {
          name
          symbol
        }
      }
    }
  }
`;

export const cargoHubsQuery = gql`
  query cargoHubs(
    $query: HubFilterInput
    $searchText: String
    $orderBy: HubOrderInput
  ) {
    hubs(
      first: 15000
      query: $query
      searchText: $searchText
      orderBy: $orderBy
    ) {
      edges {
        node {
          name
          function
          locode
          status
          coordinates
          country {
            name
            symbol
          }
        }
      }
    }
  }
`;
