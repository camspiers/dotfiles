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

let networkInterval = null;
export const command = (dispatch) => {
    clearInterval(networkInterval);
    getSpacesForDisplay(1).then(spaces => dispatch({ type: 'SPACES_UPDATED', spaces }));
    function updateNetwork() {
        run('ubersicht-network').then(network => dispatch({type: 'NETWORK_CHANGED', network}));
    }
    networkInterval = setInterval(updateNetwork, 5000);
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

const containerClass = css`
    ${defaultTheme}
    align-items: center;
    display: inline-flex;
    justify-content: space-between;
    vertical-align: top;
    margin: 0;
    margin-right: 10px;
    border-radius: unset;
`;

const spaceContainerClass = css`
    ${containerClass}
    padding: 0;

    div {
        padding: 0 2ch;
    }
`;

const spaceFocusedClass = css`
    box-shadow: inset 0px 0px 0px 1px #fff;
`;

export const render = ({ network , spaces }) => {
    return (
        <div>
            <div className={spaceContainerClass}>
                {spaces.map(space => <div className={space.focused ? spaceFocusedClass : null}>{space.index}</div>)}
            </div>
            <div className={containerClass}>{network}</div>
        </div>
    );
};

