const font = "Hasklug Nerd Font";
const fontSize = "11px";
const fontStyle = "regular";
const lineHeight = "24px";
const borderRadius = "3px";

const background = "#2E3440";
const foreground = "#D8DEE9";
const color = "#fff";
const gap = "10";

const defaultTheme = `
  z-index: 100;
  font: ${fontSize} ${font};
  font-style: ${fontStyle};
  color: ${color};
  line-height: ${lineHeight};
  background-color: ${background};
  opacity: 1;
  display: inline-block;

  padding: 0 2ch;
  margin: ${gap}px;

  position: absolute;
  top: ${gap}px;
  right: ${gap}px;
  bottom: ${gap}px;
  left: ${gap}px;

  border-top-left-radius: ${borderRadius};
  border-top-right-radius: ${borderRadius};
  border-bottom-right-radius: ${borderRadius};
  border-bottom-left-radius: ${borderRadius};
  box-shadow: 0px 1px 1px 1px rgba(0,0,0,0.15);
`;

export { defaultTheme };
