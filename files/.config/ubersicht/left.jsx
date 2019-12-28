import getSpacesForDisplay from "./lib/getSpacesForDisplay";
import { css, run } from 'uebersicht';
import { defaultTheme } from "./lib/style";

export const initialState = {
    spaces: [],
};

export const updateState = (event, state) => {
  switch(event.type) {
      case 'SPACES_UPDATED':
        return {
            ...state,
            spaces: event.spaces,
        };
      default:
        return state;
  }
}

export const command = (dispatch) => getSpacesForDisplay(1).then(spaces => dispatch({ type: 'SPACES_UPDATED', spaces }));

export const refreshFrequency = false;

export const className = `
    display: flex;
    justify-content: space-between;
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
`;

const spaceClass = css`
    position: relative;
    padding: 0 2ch;
    cusor: pointer;
`

const spaceFocusedClass = css`
    ${spaceClass}
    background-color: #4C566A;
`;

const indexClass = css`
    position: absolute;
    top: 1px;
    right: 5px;
    font-size: 9px;
    height: 12px;
    line-height: 12px;
`

function onClick(dispatch, spaces, space) {
    if (space.focused) {
        return;
    }

    dispatch({
        type: 'SPACES_UPDATED',
        spaces: spaces.map(s => ({...s, focused: space.index === s.index})),
    });

    run(`yabai -m space --focus ${space.index}`);
}

export const render = ({ spaces }, dispatch) => {

    return (
        <div className={spaceContainerClass}>
            {spaces.map(space =>
                <div
                    key={space.index}
                    className={space.focused ? spaceFocusedClass : spaceClass}
                    onClick={() => onClick(dispatch, spaces, space)}>
                    {space.label ? space.label : space.index}
                    {space.label && <span className={indexClass}>{space.index}</span>}
                </div>
            )}
        </div>
    );
};

