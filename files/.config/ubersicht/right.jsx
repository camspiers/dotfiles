import {defaultTheme} from './lib/style';
import {css, run} from 'uebersicht';

export const initialState = {
  total: '0:00',
  running: false,
  status: '',
  time: '',
  loading: true,
};

export const updateState = (event, pState) => {
  switch (event.type) {
    case 'LOADING_CHANGED':
      return {
        ...pState,
        loading: event.loading,
      };
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
};

let timeTimeout = null;
let harvestTimeout = null;

export const command = dispatch => {
  clearInterval(timeTimeout);
  clearInterval(harvestTimeout);

  dispatch({type: 'LOADING_CHANGED', loading: true});

  function updateHarvest() {
    Promise.all([
      run('htotal').then(total => dispatch({type: 'TOTAL_CHANGED', total})),
      run('hstatus').then(status => dispatch({type: 'STATUS_CHANGED', status})),
    ]).then(() => dispatch({type: 'LOADING_CHANGED', loading: false}));
  }

  function zeroPad(num, places) {
    return String(num).padStart(places, '0');
  }

  function updateTime() {
    const date = new Date();
    dispatch({
      type: 'TIME_CHANGED',
      time: `${zeroPad(date.getHours(), 2)}:${zeroPad(date.getMinutes(), 2)}:${zeroPad(date.getSeconds(), 2)}`,
    });
  }

  timeTimeout = setInterval(updateTime, 100);
  harvestTimeout = setInterval(updateHarvest, 10000);

  updateTime();
  updateHarvest();
};

export const refreshFrequency = false;

export const className = `
    display: flex;
    justify-content: space-between;
    order: 5;
    position: static;
    margin-right: 20px;
`;

const container = css`
  ${defaultTheme}
  align-items: center;
  display: inline-flex;
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

export const render = ({total, running, status, time, loading}, dispatch) => {
  return (
    <div>
      {!loading && running ? <div className={container}>{status}</div> : null}
      <div
        className={totalContainer}
        onClick={() => {
          dispatch({type: 'LOADING_CHANGED', loading: true});
          run('hcl stop').then(() => {
            Promise.all([
              run('htotal').then(total =>
                dispatch({type: 'TOTAL_CHANGED', total}),
              ),
              run('hstatus').then(status =>
                dispatch({type: 'STATUS_CHANGED', status}),
              ),
            ]).then(() => dispatch({type: 'LOADING_CHANGED', loading: false}));
          });
        }}>
        <img
          src="./assets/harvest-logo-icon.png"
          className={!loading && running ? img : greyscale}
        />
        <span>{loading ? '--' : total}</span>
      </div>
      <div className={container}>{time}</div>
    </div>
  );
};
