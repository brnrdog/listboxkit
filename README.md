# Listbox

React hooks written in ReScript for building accessible listbox components.

## Installation

```sh
npm install --save @brnrdog/listbox
```

## Usage

The`useListbox` hook provides primitives to build custom listbox components.

### Usage in a Javascript/Typescript project:

```ts
import React from "react";
import { useListbox } from "@brnrdog/listbox";

const options = [
  { text: "Red", value: "#FF0000" },
  { text: "Green", value: "#00FF00" },
  { text: "Blue", value: "#0000FF" },
];

function ColorsListbox() {
  const { highlightedIndex, selectedIndex, getOptionProps } = useListbox(
    options
  );

  return (
    <ul>
      {options.map((option, index) => {
        const style = {
          textDecoration: index === highlightedIndex ? "underline" : "none",
          fontWeight: index === selectedIndex ? 600 : 400,
        };
        return (
          <li style={style} key={option.value} {...getOptionProps(index)}>
            {option.text}
          </li>
        );
      })}
    </ul>
  );
}
```

[Click here](https://github.com/brnrdog/listbox/tree/master/examples/typescript/src/App.tsx) for a typescript example.

### Usage in a Reason/ReScript Project:

Soon.

## Contributing

Soon.
