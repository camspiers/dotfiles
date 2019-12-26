import { defaultTheme } from "./lib/style";

const command = "bash ~/.dotfiles/scripts/ubersicht-network";
const refreshFrequency = 5000; // ms

const renderClass = `
  ${defaultTheme}
  right: auto;
  bottom: auto;
  margin-left: calc(5ch + 20px);
`;

const render = ({ output }) => <div>{`${output}`}</div>;

export { command, refreshFrequency, renderClass as className, render };
