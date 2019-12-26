import { defaultTheme } from "./lib/style";
import { css, run } from 'uebersicht';

export const initialState = {
    total: '0:00',
    running: false,
    status: '',
    time: '',
};

export const updateState = (event, pState) => {
  switch(event.type) {
      case 'STATUS_CHANGED':
        return {
            ...pState,
            status: event.status,
            running: event.status !== 'Start Timer',
        };
      case 'TOTAL_CHANGED':
        return {
            ...pState,
            total: event.total,
        };
      case 'TIME_CHANGED':
        return {
            ...pState,
            time: event.time,
        };
      default:
        return pState;
  }
}

const command = (dispatch) => {
    run('htotal').then(total => dispatch({type: 'TOTAL_CHANGED', total}));
    run('hstatus').then(status => {
        dispatch({type: 'STATUS_CHANGED', status});
    });
    run('date +"%I:%M %p"').then(time => dispatch({type: 'TIME_CHANGED', time}));
};

const refreshFrequency = 2000; // ms

const className = `
    display: flex;
    justify-content: space-between;
    margin: 15px 20px;
    order: 5;
    position: static;
`;

const container = css`
    ${defaultTheme}
    align-items: center;
    display: inline-flex;
    justify-content: space-between;
    vertical-align: top;
    margin: 0;
    margin-left: 10px;
`;

const totalContainer = css`
    ${container}
    padding-left: 0;
`;

const img = css`
    margin-right: 2ch;
    height: 24px;
    width: 24px;
`;

const greyscale = css`
    ${img}
    filter: grayscale(100%);
`;

const render = ({ total, running, status, time }, dispatch) => {
    return (
        <div>
            {running ? <div className={container}>{status}</div> : null}
            <div className={totalContainer} onClick={() => command(dispatch)}>
                <img src="./assets/harvest-logo-icon.png" className={running ? img : greyscale} />
                <span>{total}</span>
            </div>
            <div className={container}>{time}</div>
        </div>
    );
};

export { command, refreshFrequency, className, render };
