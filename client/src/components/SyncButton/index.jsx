import React, { useState } from "react";
import { Mutation } from "react-apollo";
import { updateHubsMutation } from "../../modules/home/mutations";
import PusherChannel from "../../services/PusherService";

export const SyncButtonContainer = () => {
  const initialState = { processing: false, message: null };
  const [state, setState] = useState(initialState);
  PusherChannel.bind("sync-updates", data => {
    if (data.message === "Done, the tables should update in a few minutes") {
      return setState({ ...state, processing: false });
    }
    setState({ ...state, message: data.message });
  });
  return (
    <Mutation mutation={updateHubsMutation}>
      {({ updateHubsMutation }) => {
        return (
          <SyncButton
            processing={state.processing}
            handleButtonPress={updateHubsMutation}
          />
        );
      }}
    </Mutation>
  );
};

const SyncButton = ({ processing, handleButtonPress }) => (
  <div style={{ marginTop: "5%" }}>
    {processing ? (
      <div>{state.message}</div>
    ) : (
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
