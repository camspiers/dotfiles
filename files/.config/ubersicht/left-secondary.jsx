import getSpacesForDisplay from "./lib/getSpacesForDisplay";
import { run } from 'uebersicht';
import { updateState, refreshFrequency, className, render } from './left.jsx';

export const initialState = {
    network: '',
    spaces: [],
};

const command = (dispatch) => {
    getSpacesForDisplay(2).then(spaces => dispatch({ type: 'SPACES_UPDATED', spaces }));
    run('ubersicht-network').then(network => dispatch({type: 'NETWORK_CHANGED', network}));
};

export { command, updateState, refreshFrequency, className, render };
