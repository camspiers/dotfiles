import getSpacesForDisplay from './lib/getSpacesForDisplay';
import {css, run} from 'uebersicht';
import {defaultTheme} from './lib/style';

export const initialState = {
  spaces: [],
  focused: 0,
};

export const updateState = (event, state) => {
  switch (event.type) {
    case 'SPACES_UPDATED':
      const focused = event.spaces.find(s => s.focused);
      return {
        spaces: event.spaces,
        focused: focused ? focused.index : 0,
      };
    case 'FOCUSED_UPDATED':
      return {
        ...state,
        focused: event.focused,
      };
  }
  return state;
};

// This whole feature is a ridiculous bit of shenanigans
// A swift commandline tool called activespace was created to report changes to
// the active space. A node commandline tool activeSpaceServer runs this
// command and then uses SSE's to send the active spaces to the following
// event source. This is all because the yabai -> AppleScript Ubersicht -> Widget
// solution was very slow (probably because of AppleScript + Ubersicht
// refresh functionality)
export const init = dispatch => {
  getSpacesForDisplay(1).then(spaces =>
    dispatch({
      type: 'SPACES_UPDATED',
      spaces,
    }),
  );

  // Create the new event source for the active spaces server
  const activeSpace = new EventSource('//127.0.0.1:15997');

  // Check whether the server is running
  activeSpace.onerror = () => {
    // Failed to connect, start the activeSpaceServer then init again
    run('node ./lib/activespaceServer.js &').then(() => init(dispatch));
  };

  // Set the active spacce when we receive data from the server
  activeSpace.onmessage = event => {
    dispatch({
      type: 'FOCUSED_UPDATED',
      focused: Number(event.data),
    });
  };
};

export const command = undefined;
export const refreshFrequency = false;

export const className = `
  ${defaultTheme}
  display: flex;
  order: 1;
  padding: 0;
  div:first-of-type {
    border-top-left-radius: 3px;
    border-bottom-left-radius: 3px;
  }
  div:last-of-type {
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

const Space = ({space, focused, dispatch}) => (
  <div
    key={space.index}
    className={space.index === focused ? spaceFocusedClass : spaceClass}>
    {space.label ? space.label : space.index}
    {space.label && <span className={indexClass}>{space.index}</span>}
  </div>
);

export const render = ({spaces, focused}, dispatch) =>
  spaces.map(space => (
    <Space focused={focused} space={space} dispatch={dispatch} />
  ));
