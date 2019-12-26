import { defaultTheme } from "./lib/style";

const command = "bash ~/.dotfiles/scripts/ubersicht-workspace";
const refreshFrequency = 100; // ms

const renderClass = `
  ${defaultTheme}
  right: auto;
  bottom: auto;
  font-weight: bold;
`;

const render = ({ output }) => <div>{`${output}`}</div>;

export { command, refreshFrequency, renderClass as className, render };
