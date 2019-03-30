import gql from 'graphql-tag'

export const cargoHubsQuery = gql`
    query cargoHubs($query: HubFilterInput, $searchText: String, $orderBy: HubOrderInput){
        hubs(first: 20, query: $query, searchText: $searchText, orderBy: $orderBy) {
          edges {
            node {
              name,
              country {
                name
                symbol
              }
            }
          }
        }
      }` 