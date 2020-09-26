type optionProps = {
  @bs.as("aria-selected") ariaSelected: bool,
  role        : string,
  tabIndex    : int,
  onClick     : ReactEvent.Mouse.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
}

type listbox = {
  highlightedIndex : int,
  selectedIndexes  : array<int>,
  getOptionProps   : int => optionProps,
}

let noop = () => ()

let useListbox = (~options) => {
  let size = Belt.Array.length(options)
  let {
    highlightedIndex,
    selectedIndexes,
    selectIndex,
    highlightNext,
    highlightPrev,
    highlightFirst,
    highlightLast,
    selectHighlighted,
  }: Controls.Listbox.controls = Controls.Listbox.useControls(~size)

  let getOptionProps = index => {
    ariaSelected: Belt.Array.some(selectedIndexes, i => i == index),
    role: "option",
    tabIndex: 0,
    onClick: EventHandlers.onClick(~index, ~selectIndex),
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
    getOptionProps,
  }
}
