import { defaultTheme } from "./lib/style";
import { css, run } from 'uebersicht';

export const initialState = {
    workspace: '1',
    network: '',
};

export const updateState = (event, pState) => {
  switch(event.type) {
      case 'WORKSPACE_CHANGED':
        return {
            ...pState,
            workspace: event.workspace,
        };
      case 'NETWORK_CHANGED':
        return {
            ...pState,
            network: event.network,
        };
      default:
        return pState;
  }
}

const command = (dispatch) => {
    run('ubersicht-workspace').then(workspace => {
        dispatch({type: 'WORKSPACE_CHANGED', workspace});
    });
    run('ubersicht-network').then(network => {
        dispatch({type: 'NETWORK_CHANGED', network});
    });
};

const refreshFrequency = 2000; // ms

const className = `
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

const render = ({ workspace, network }, dispatch) => {
    return (
        <div>
            <div className={container}>{workspace}</div>
            <div className={container}>{network}</div>
        </div>
    );
};

export { command, refreshFrequency, className, render };
