type containerProps = {
  role        : string,
  tabIndex    : int,
  onBlur      : ReactEvent.Focus.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
  onFocus     : ReactEvent.Focus.t => unit,
}

type optionProps = {
  @bs.as("aria-selected") 
  ariaSelected: bool,
  role        : string,
  onClick     : ReactEvent.Mouse.t => unit,
}

type listbox = {
  highlightedIndex : int,
  selectedIndexes  : array<int>,
  getOptionProps   : int => optionProps,
  getContainerProps: () => containerProps,
}

let noop = () => ()

let useListbox = (options, ~multiSelect = false, ()) => {
  let size = Belt.Array.length(options)
  let {
    highlightedIndex,
    resetHighlighted,
    selectedIndexes,
    selectIndex,
    highlightIndex,
    highlightNext,
    highlightPrev,
    highlightFirst,
    highlightLast,
    selectHighlighted,
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
      ~menuVisible = true,
      ~hideMenu = noop,
      ~highlightFirst, 
      ~highlightLast, 
      ~highlightNext,
      ~selectPrev,
      ~selectNext, 
      ~highlightPrev,
      ~selectHighlighted,
      ~showMenu = () => (),
    )
  }

  {
    highlightedIndex,
    selectedIndexes,
    getContainerProps,
    getOptionProps,
  }
}
