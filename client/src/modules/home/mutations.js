import gql from "graphql-tag";

export const updateHubsMutation = gql`
  mutation updateHubs {
    updateHubs(input: {}) {
      hubs {
        name
        id
      }
    }
  }
`;
