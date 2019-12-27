import getSpacesForDisplay from "./lib/getSpacesForDisplay";
import { css, run } from 'uebersicht';
import { defaultTheme } from "./lib/style";

export const initialState = {
    network: '',
    spaces: [],
};

export const updateState = (event, state) => {
  switch(event.type) {
      case 'NETWORK_CHANGED':
        return {
            ...state,
            network: event.network,
        };
      case 'SPACES_UPDATED':
        return {
            ...state,
            spaces: event.spaces,
        };
      default:
        return state;
  }
}

let networkTimeout = null;

export const command = (dispatch) => {
    clearInterval(networkTimeout);
    getSpacesForDisplay(1).then(spaces => dispatch({ type: 'SPACES_UPDATED', spaces }));
    const updateNetwork = () => run('ubersicht-network').then(network => dispatch({type: 'NETWORK_CHANGED', network}));
    networkTimeout = setInterval(updateNetwork, 5000);
    updateNetwork();
};

export const refreshFrequency = false;

export const className = `
    display: flex;
    justify-content: space-between;
    margin: 15px 20px;
    order: 1;
    position: static;
`;

const container = css`
    ${defaultTheme}
    align-items: center;
    display: inline-flex;
    justify-content: space-between;
    vertical-align: top;
    margin: 0;
    margin-right: 10px;
`;

const containerFocused = css`
    ${container}
    box-shadow:inset 0px 0px 0px 1px #fff;
`;

export const render = ({ network , spaces }) => {
    return (
        <div>
            {spaces.map(space => <div className={space.focused ? containerFocused : container}>{space.index}</div>)}
            <div className={container}>{network}</div>
        </div>
    );
};

