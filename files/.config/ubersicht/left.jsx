import getSpacesForDisplay from './lib/getSpacesForDisplay';
import {css, run} from 'uebersicht';
import {defaultTheme} from './lib/style';

export const initialState = [];

export const updateState = (event, state) => {
  switch (event.type) {
    case 'SPACES_UPDATED':
      return event.spaces;
  }
  return state;
};

export const command = dispatch =>
  getSpacesForDisplay(1).then(spaces =>
    dispatch({
      type: 'SPACES_UPDATED',
      spaces,
    }),
  );

export const refreshFrequency = false;

export const className = `
  ${defaultTheme}
  display: flex;
  order: 1;
  padding: 0;
  div:first-child {
    border-top-left-radius: 3px;
    border-bottom-left-radius: 3px;
  }
  div:last-child {
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
  }
`;

const spaceClass = css`
  padding: 0 2ch;
  position: relative;
`;

const spaceFocusedClass = css`
  ${spaceClass}
  background-color: #81A1C1;
  color: #2e3440;
`;

const indexClass = css`
  font-size: 10px;
  height: 12px;
  line-height: 12px;
  position: absolute;
  right: 5px;
  top: 2px;
`;

function onClick(dispatch, spaces, space) {
  if (space.focused) {
    return;
  }

  run(`yabai -m space --focus ${space.index}`);

  // Optimistic update
  dispatch({
    type: 'SPACES_UPDATED',
    spaces: spaces.map(s => ({...s, focused: space.index === s.index})),
  });
}

const Space = ({spaces, space, dispatch}) => (
  <div
    key={space.index}
    className={space.focused ? spaceFocusedClass : spaceClass}
    onClick={() => onClick(dispatch, spaces, space)}
    onMouseOver={() => onClick(dispatch, spaces, space)}>
    {space.label ? space.label : space.index}
    {space.label && <span className={indexClass}>{space.index}</span>}
  </div>
);

export const render = (spaces, dispatch) =>
  spaces.map(space => (
    <Space spaces={spaces} space={space} dispatch={dispatch} />
  ));
