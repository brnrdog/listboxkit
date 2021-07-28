type listboxContainerProps = {
  role        : string,
  tabIndex    : int,
  onBlur      : ReactEvent.Focus.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
  onFocus     : ReactEvent.Focus.t => unit,
}

type listboxOptionProps = {
  @bs.as("aria-selected") 
  ariaSelected: bool,
  role        : string,
  onClick     : ReactEvent.Mouse.t => unit,
}

type listbox = {
  highlightedIndex : int,
  selectedIndex    : int,
  selectedIndexes  : array<int>,
  getContainerProps: () => listboxContainerProps,
  getOptionProps   : int => listboxOptionProps,
}

let noop = () => ()

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
