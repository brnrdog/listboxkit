type containerProps = {
  role        : string,
  tabIndex    : int,
  onBlur      : ReactEvent.Focus.t => unit,
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
  selectedIndexes  : array<int>,
  getOptionProps   : int => optionProps,
  getContainerProps: () => containerProps,
}

let noop = () => ()

let useListbox = (~options) => {
  let size = Belt.Array.length(options)
  let {
    highlightedIndex,
    resetHighlighted,
    selectedIndexes,
    selectIndex,
    highlightNext,
    highlightPrev,
    highlightFirst,
    highlightLast,
    selectHighlighted,
  } = Controls.Listbox.useControls(~size)

  let getOptionProps = index => {
    ariaSelected: Belt.Array.some(selectedIndexes, i => i == index),
    role: "option",
    onClick: EventHandlers.onClick(~index, ~selectIndex),
  }

  let getContainerProps = () => {
    role: "listbox",
    tabIndex: 0,
    onBlur: EventHandlers.onBlur(~resetHighlighted),
    onKeyDown: EventHandlers.onKeyDown(
      ~menuVisible = true,
      ~hideMenu = noop,
      ~highlightFirst, 
      ~highlightLast, 
      ~highlightNext, 
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
