import { defaultTheme } from "./lib/style";

export const command = 'date +"%a, %d %b %y"';
export const refreshFrequency = 100000; // ms
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
export const render = ({ output }) => <div>{output}</div>;
