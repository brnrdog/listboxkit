let noop = () => ()

type containerProps = {
  role        : string,
  tabIndex    : int,
  onBlur      : ReactEvent.Focus.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
  onFocus     : ReactEvent.Focus.t => unit,
}

type dropdownProps = {
  role    : string,
  tabIndex: int,
  onClick : ReactEvent.Mouse.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
}

type optionProps = {
  @bs.as("aria-selected") 
  ariaSelected: bool,
  role        : string,
  onClick     : ReactEvent.Mouse.t => unit,
}

type listbox = {
  highlightedIndex : int,
  selectedIndex    : int,
  selectedIndexes  : array<int>,
  getContainerProps: () => containerProps,
  getOptionProps   : int => optionProps,
}


let useListbox = (options, ~multiSelect = false, ()) => {
  let size = options -> Belt.Array.length
  let {
    highlightedIndex,
    highlightFirst,
    highlightIndex,
    highlightLast,
    highlightNext,
    highlightPrev,
    resetHighlighted,
    selectedIndex,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
    selectNext,
    selectPrev,
  } = Controls.Listbox.useControls(~multiSelect, ~size)

  let getOptionProps = index => {
    ariaSelected: Belt.Array.some(selectedIndexes, i => i == index),
    role: "option",
    onClick: EventHandlers.onClick(~index, ~selectIndex),
  }

  let getContainerProps = () => {
    role: "listbox",
    tabIndex: 0,
    onBlur: EventHandlers.onBlur(~resetHighlighted),
    onFocus: EventHandlers.onFocus(~highlightIndex, ~selectedIndexes),
    onKeyDown: EventHandlers.onKeyDown(
      ~hideMenu = noop,
      ~highlightFirst, 
      ~highlightLast, 
      ~highlightNext,
      ~highlightPrev,
      ~menuVisible = true,
      ~selectHighlighted,
      ~selectNext, 
      ~selectPrev,
      ~showMenu = noop,
    )
  }

  {
    getContainerProps,
    getOptionProps,
    highlightedIndex,
    selectedIndex,
    selectedIndexes,
  }
}

type dropdownListbox = {
  highlightedIndex : int,
  menuVisible      : bool,
  selectedIndex    : int,
  selectedIndexes  : array<int>,
  getContainerProps: () => containerProps,
  getDropdownProps : () => dropdownProps,
  getOptionProps   : int => optionProps,
  hideMenu         : () => (),
  showMenu         : () => (),
}

let useDropdownListbox = (options, ~multiSelect = false, ()) => {
  let size = options -> Belt.Array.length 
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
    onBlur: EventHandlers.onBlur(~resetHighlighted),
    onFocus: EventHandlers.onFocus(~highlightIndex, ~selectedIndexes),
    onKeyDown: _ => ()
  }

  let getDropdownProps = () => {
    role: "button",
    tabIndex: 0,
    onClick: EventHandlers.onDropdownClick(~menuVisible, ~hideMenu, ~showMenu),
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
    )
  }

  {
    getContainerProps,
    getDropdownProps,
    getOptionProps,
    hideMenu,
    highlightedIndex,
    menuVisible,
    selectedIndex,
    selectedIndexes,
    showMenu
  }
}