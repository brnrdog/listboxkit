---
id: use_listbox
title: useListbox
sidebar_label: useListbox
slug: /use_listbox
---

The useListbox hook provides the basic behaviours for implementing listbox components.

Given a list of options, this hook returns a `listbox` record containing the listbox current state and functions to bind event handlers and aria attributes.

```res
  let options = ["Red", "Green", "Blue"]
  let listbox = Listboxkit.useListbox(options, ~multiselect=true, ())
```

| Properties        | Type                          | Description                                                                     |
| ----------------- | ----------------------------- | ------------------------------------------------------------------------------- |
| highlightedIndex  | int                           | The current highlighted index, returns `-1` when no option is highlighted.      |
| selectedIndex     | int                           | The current selected index, returns `-1` when no option is selected.            |
| selectedIndexes   | array<int\>                   | The current selected indexes, in case is a `multiselect` is `true`.             |
| getContainerProps | unit => listboxContainerProps | Returns a record containing the properties to be used in the container element. |
| getOptionProps    | unit => listboxOptionProps    | Returns a record containing the properties to be used in the option elements.   |

### Example

```rescript
module ColorSelect = {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = () => {
    open Listboxkit
    open Belt

    let {
      highlightedIndex,
      getOptionProps,
      getContainerProps,
      selectedIndex,
    }: Listboxkit.listbox = Listboxkit.useListbox(options, ())

    let {role, tabIndex, onKeyDown, onFocus, onBlur} = getContainerProps()

    let selectedOption = options
			->Array.get(selectedIndex)
			->Option.getWithDefault("no selected color.")

    let renderOption = (index, option) => {
      let {ariaSelected, onClick, role}: listboxOptionProps = getOptionProps(index)
      let highlighted = highlightedIndex == index

      <li key=option onClick onKeyDown role ariaSelected>
        {(highlighted ? `> ${option}` : option) |> React.string}
      </li>
    }

    <div>
      {React.string("Selected color :" ++ selectedOption)}
      <ul role tabIndex onKeyDown onFocus onBlur>
        {options->Belt.Array.mapWithIndex(renderOption)->React.array}
      </ul>
    </div>
  }
}
```
