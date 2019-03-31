import React, { useState, useEffect } from "react";
import { Mutation } from "react-apollo";
import { updateHubsMutation } from "../../modules/home/mutations";
import PusherChannel from "../../services/PusherService";

export const SyncButtonContainer = () => {
  const initialState = { processing: false, message: null };
  const [state, setState] = useState(initialState);

  useEffect(() => {
    PusherChannel.bind("sync-updates", data => {
      setState({
        ...state,
        message: data.message,
        processing: false,
        serverResponse: true
      });
    });
  }, []);

  return (
    <Mutation mutation={updateHubsMutation}>
      {updateHubs => {
        return (
          <SyncButton
            processing={state.processing}
            message={state.message}
            serverResponse={state.serverResponse}
            handleButtonPress={() => {
              setState({
                ...state,
                processing: true,
                message: "Alright, we're syncing"
              });
              updateHubs();
            }}
          />
        );
      }}
    </Mutation>
  );
};

const SyncButton = ({
  processing,
  handleButtonPress,
  message,
  serverResponse
}) => (
  <div style={{ marginTop: "5%" }}>
    {(processing || serverResponse) && <p>{message || serverResponse} </p>}
    {!processing && (
      <button
        onClick={e => {
          e.preventDefault();
          handleButtonPress();
        }}
      >
        Reimport data from UN
      </button>
    )}
  </div>
);
