# Listbox

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/brnrdog/listbox/Release?style=flat-square)
[![npm](https://img.shields.io/npm/v/@brnrdog/listbox?style=flat-square)](https://www.npmjs.com/package/@brnrdog/listbox)
![npm bundle size](https://img.shields.io/bundlephobia/min/@brnrdog/listbox?style=flat-square)
![Codecov](https://img.shields.io/codecov/c/github/brnrdog/listbox?style=flat-square)

Small and flexible React hooks for building custom and accessible listbox components. 

## Installation

Install it using the package manager of your preference:

```bash
npm install --save @brnrdog/listbox
```

Or if your project uses yarn:

```bash
yarn add @brnrdog/listbox
```

For **ReScript** projects, add `@brnrdog/listbox` as a dependency in your `bsconfig.json` file:

```json
{
  "bs-dependencies": [
    "@brnrdog/listbox"
  ]
}
```

## Usage

The main React hook for building listbox components is the `useListbox`. Given a list of options, this hook will provide the state and the necessary event handlers for building your listbox.

### Using in JavaScript/TypeScript projects:

```js
const options = ["Red", "Green", "Blue"];

function ColorSelect() {
  const {
    highlightedIndex,
    getOptionProps,
    getContainerProps,
    selectedIndexes
  } = useListbox(options);

  const selectedColors = selectedIndexes.map(i => options[i]).join(",")

  return (
    <div>
      Selected color:{" "}
      {selectedColors.length === 0 ? "no selected color" : selectedColors}.
      <ul {...getContainerProps()}>
        {options.map((option, index) => {
          const highlighted = highlightedIndex === index;

          return (
            <li {...getOptionProps(index)}>
              {highlighted ? `> ${option}` : option}
            </li>
          );
        })}
      </ul>
    </div>
  );
```

### Using in ReScript projects:

```rescript
module ColorSelect {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = () => {
    let {
      highlightedIndex,
      getOptionProps,
      getContainerProps,
      selectedIndexes
    }: Listbox.listbox = Listbox.useListbox(options)

    let { role, tabIndex, onKeyDown, onFocus, onBlur } = getContainerProps()

    let selectedOption = selectedIndexes
    -> Belt.Array.map(i => options -> Belt.Array.get(i))
    -> Belt.Array.get(0)
    -> Belt.getWithDefault("no selected color.")

    let renderColorOption = (index, option) => {
      let {
        ariaSelected,
        onClick,
        role,
      }: Listbox.optionProps = getOptionProps(index)
      let highlighted =  highlightedIndex == index

      <li key=option onClick onKeyDown role ariaSelected>
        {(highlighted ? `> ${option}` : option) |> React.string}
      </li>
    }

    <div>
      {React.string("Selected color :" ++ selectedOption)}
      <ul role tabIndex onKeyDown onFocus onBlur>
        {options
          -> Belt.Array.mapWithIndex(renderOption)
          -> React.array}
      </ul>
    </div>
  }
}
```