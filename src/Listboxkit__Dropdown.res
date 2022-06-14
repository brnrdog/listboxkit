type dropdownContainerProps = {
  role: string,
  tabIndex: int,
  onKeyDown: ReactEvent.Keyboard.t => unit,
  onFocus: ReactEvent.Focus.t => unit,
}

type dropdownProps = {
  role: string,
  tabIndex: int,
  onBlur: ReactEvent.Focus.t => unit,
  onClick: ReactEvent.Mouse.t => unit,
  onKeyDown: ReactEvent.Keyboard.t => unit,
}

type dropdownOptionProps = {
  @as("aria-selected")
  ariaSelected: bool,
  role: string,
  onClick: ReactEvent.Mouse.t => unit,
}

type dropdownListbox = {
  highlightedIndex: int,
  menuVisible: bool,
  selectedIndex: int,
  selectedIndexes: array<int>,
  getContainerProps: unit => dropdownContainerProps,
  getDropdownProps: unit => dropdownProps,
  getOptionProps: int => dropdownOptionProps,
  hideMenu: unit => unit,
  showMenu: unit => unit,
  resetHighlighted: unit => unit,
}

let useDropdownListbox = (options, ~multiSelect=false, ~highlightFirstOnOpen=false, ()) => {
  let size = options->Belt.Array.length
  let {
    hideMenu,
    highlightedIndex,
    highlightFirst,
    highlightIndex,
    highlightLast,
    highlightNext,
    highlightPrev,
    menuVisible,
    resetHighlighted,
    selectedIndex,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
    selectNext,
    selectPrev,
    showMenu,
  }: Controls.DropdownListbox.controls = Controls.DropdownListbox.useControls(~multiSelect, ~size)

  let getOptionProps = index => {
    ariaSelected: Belt.Array.some(selectedIndexes, i => i == index),
    role: "option",
    onClick: EventHandlers.onClick(~index, ~selectIndex),
  }

  let getContainerProps = () => {
    role: "listbox",
    tabIndex: 0,
    onFocus: EventHandlers.onFocus(~highlightIndex, ~selectedIndexes),
    onKeyDown: _ => (),
  }

  let getDropdownProps = () => {
    role: "combobox",
    tabIndex: 0,
    onClick: EventHandlers.onDropdownClick(~menuVisible, ~hideMenu, ~showMenu),
    onBlur: EventHandlers.onBlur(~resetHighlighted, ~menuVisible, ~hideMenu),
    onKeyDown: EventHandlers.onKeyDown(
      ~menuVisible,
      ~hideMenu,
      ~highlightFirst,
      ~highlightLast,
      ~highlightNext,
      ~selectPrev,
      ~selectNext,
      ~highlightPrev,
      ~selectHighlighted,
      ~showMenu,
      ~highlightFirstOnOpen,
    ),
  }

  {
    getContainerProps: getContainerProps,
    getDropdownProps: getDropdownProps,
    getOptionProps: getOptionProps,
    hideMenu: hideMenu,
    highlightedIndex: highlightedIndex,
    menuVisible: menuVisible,
    selectedIndex: selectedIndex,
    selectedIndexes: selectedIndexes,
    showMenu: showMenu,
    resetHighlighted: resetHighlighted,
  }
}
