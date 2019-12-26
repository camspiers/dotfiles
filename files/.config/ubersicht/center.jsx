import { defaultTheme } from "./lib/style";

const command = 'date +"%a, %d %b %y"';
const refreshFrequency = 100000; // ms

const renderClass = `
  ${defaultTheme}
  order: 2;
`;

const render = ({ output }) => <div>{output}</div>;

export { command, refreshFrequency, renderClass as className, render };
