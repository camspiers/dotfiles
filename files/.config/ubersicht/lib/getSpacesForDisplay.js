import { run } from 'uebersicht';

export default function getSpacesForDisplay(index) {
    return run(`yabai -m query --spaces --display ${index}`)
        .then(json => JSON.parse(json));
};
