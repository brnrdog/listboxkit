# @brnrdog/listbox

React hooks written in ReScript for building accessible listbox components.

## Installation

```sh
npm install --save @brnrdog/list-box
```

## Usage

The`useListbox` hook provides primitives to build custom listbox components.

### Usage in a Javascript/Typescript project:

```ts
const options = [
  { text: "Red", value: "#FF0000" },
  { text: "Green", value: "#00FF00" },
  { text: "Blue", value: "#0000FF" },
];

const { highlightedIndex, selectedIndex, getOptionProps } = useListbox(options);
```

[Click here](https://github.com/brnrdog/listbox/tree/master/examples/typescript/src/App.tsx) for a typescript example.

### Usage in a Reason/ReScript Project:

Soon.

## Contributing

Soon.
