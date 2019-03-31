import gql from 'graphql-tag'

export const cargoHubsQuery = gql`
    query cargoHubs($query: HubFilterInput, $searchText: String, $orderBy: HubOrderInput){
        hubs(first: 100, query: $query, searchText: $searchText, orderBy: $orderBy) {
          edges {
            node {
              name,
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
      }` 