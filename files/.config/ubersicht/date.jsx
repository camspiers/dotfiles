import { defaultTheme } from "./lib/style";

const command = 'date +"%a, %d %b %y"';
const refreshFrequency = 100000; // ms

const renderClass = `
  ${defaultTheme}
  width: auto;
  right: auto;
  bottom: auto;
  left: 50%;
  text-align: center;
  transform: translate(-50%);
`;

const render = ({ output }) => <div>{`${output}`}</div>;

export { command, refreshFrequency, renderClass as className, render };
