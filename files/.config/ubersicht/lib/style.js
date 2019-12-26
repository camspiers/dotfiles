const font = "Hasklug Nerd Font";
const fontSize = "12px";
const lineHeight = "24px";

// Nord
const background = "#2E3440";
const color = "#ffffff";
const borderRadius = "3px";

const defaultTheme = `
    position: static;
    font: ${fontSize} ${font};
    color: ${color};
    line-height: ${lineHeight};
    height: ${lineHeight};
    background-color: ${background};
    padding: 0 2ch;
    margin: 15px 0;
    border-top-left-radius: ${borderRadius};
    border-top-right-radius: ${borderRadius};
    border-bottom-right-radius: ${borderRadius};
    border-bottom-left-radius: ${borderRadius};
`;

export { defaultTheme };
