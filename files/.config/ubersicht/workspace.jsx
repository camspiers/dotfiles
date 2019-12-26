import { defaultTheme } from "./lib/style";

const command = "ubersicht-workspace";
const refreshFrequency = false;

const renderClass = `
  ${defaultTheme}
  right: auto;
  bottom: auto;
  font-weight: bold;
`;

const render = ({ output }) => <div>{`${output}`}</div>;

export { command, refreshFrequency, renderClass as className, render };
