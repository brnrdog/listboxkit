# @brnrdog/listbox

React hooks written in ReScript for building accessible listbox components.

## Installation

```sh
npm install --save @brnrdog/list-box
```

## Usage

### Usage in ReScript React applications:

```res

let options: array<colorOption> = [
  {value: "#ff0000", text: "Red"},
  {value: "#00ff00", text: "Green"},
  {value: "#0000ff", text: "Blue"},
]

@react.component
let make = (~value=?) => {
  let {
    menuVisible,
    highlightedIndex,
    selectedIndex,
    getOptionProps,
    getToggleProps,
    getLabelProps,
    getMenuProps,
    showMenu,
    hideMenu,
  }: DropdownListbox.dropdownListbox = Listbox.useDropdownListbox(
    ~labelId="color"
    ~options,
    ()
  )

  let labelProps = getLabelProps()
  let toggleProps = getToggleProps()

  let displayValue = option => option.value == Option.getUnsafe(value) 
    |> Array.getBy(options) 
    |> (selectedOption) => {
      switch selectedOption {
      | Some(option) => option.text
      | None => placeholder
      }
    }
  )

  <div>
    <label id=labelProps.id>
      {React.string("Select a color:")}
    </label>
    <div 
      onClick=toggleProps.onClick 
      onKeyDown=toggleProps.onKeyDown 
      onBlur=toggleProps.onBlur
    >
      {React.string(displayValue)}
    </div>
    {switch menuVisible {
    | true => {
      <ul>
        options->Belt.Array.mapWithIndex((index, option) => {
        let highlighted = index == highlightedIndex
        let optionProps = getOptionProps(index)

        <li
          key=string_of_int(index)
          ariaSelected=optionProps.ariaSelected
          onClick=optionProps.onClick
        />
      })->React.array}
      </ul>
    }
    | false => React.null
    }}
  </div>
}
```

### Usage in TypeScript/JavaScript applications:

Soon.

## Contributing

Soon.
