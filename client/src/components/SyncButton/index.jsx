import React, { useState, useEffect } from "react";
import { Mutation } from "react-apollo";
import { updateHubsMutation } from "../../modules/home/mutations";
import PusherChannel from "../../services/PusherService";

export const SyncButtonContainer = props => {
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
      props.refetch();
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
                message: null
              });
              updateHubs();
            }}
          />
        );
      }}
    </Mutation>
  );
};

const SyncButton = ({ processing, handleButtonPress, message }) => (
  <div style={{ marginTop: "5%" }}>
    {processing && <div className="ui active inline loader" />}
    {message && <p>{message} </p>}
    {!processing && (
      <div
        className="ui animated button"
        tabindex="0"
        onClick={e => {
          e.preventDefault();
          handleButtonPress();
        }}
      >
        <div className="visible content"> Synchronise data </div>
        <div className="hidden content">
          <i className="right arrow icon" />
        </div>
      </div>
    )}
  </div>
);
