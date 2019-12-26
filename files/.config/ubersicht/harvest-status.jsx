import { defaultTheme } from "./lib/style";

const command = "hstatus";
const refreshFrequency = 2000; // ms

const renderClass = `
  ${defaultTheme}
  bottom: auto;
  font-weight: bold;
  left: auto;
  margin-right: calc(22ch + 20px);
`;

const render = ({ output }) => <div>{`${output}`}</div>;

export { command, refreshFrequency, renderClass as className, render };
