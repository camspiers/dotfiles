import {defaultTheme} from './lib/style';

const days = {
    0: "Sun",
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
};

const months = {
    0: "Jan",
    1: "Feb",
    2: "Mar",
    3: "Apr",
    4: "May",
    5: "Jun",
    6: "Jul",
    7: "Aug",
    8: "Sep",
    9: "Oct",
    10: "Nov",
    11: "Dec",
};

function getDate() {
    const date = new Date();
    return `${days[date.getDay()]}, ${date.getDate()} ${months[date.getMonth()]} ${date.getFullYear()}`;
}

export const command = () => {};
export const refreshFrequency = 10000;

export const className = `
    ${defaultTheme}
    position: absolute;
    width: auto;
    right: auto;
    bottom: auto;
    left: 50%;
    text-align: center;
    transform: translate(-50%);
`;

export const render = () => <div>{getDate()}</div>;
