type optionProps = {
  ariaSelected: bool,
  role        : string,
  onClick     : ReactEvent.Mouse.t => unit,
  onKeyDown   : ReactEvent.Keyboard.t => unit,
}

type listbox = {
  highlightedIndex: int,
  selectedIndex   : int,
  getOptionProps  : int => optionProps,
}

let useListbox = (~options) => {
  let size = Belt.Array.length(options)
  let {
    highlightedIndex,
    selectedIndex,
    selectIndex,
    highlightNext,
    highlightPrev,
    highlightFirst,
    highlightLast,
    selectHighlighted,
  }: Controls.Listbox.controls = Controls.Listbox.useControls(~size)

  let getOptionProps = index => {
    ariaSelected: selectedIndex == highlightedIndex,
    role: "option",
    onClick: EventHandlers.onClick(~index, ~selectIndex),
    onKeyDown: EventHandlers.onKeyDown(
      ~menuVisible = true,
      ~hideMenu = () => (),
      ~highlightFirst, 
      ~highlightLast, 
      ~highlightNext, 
      ~highlightPrev,
      ~selectHighlighted
      ~showMenu = () => (),
    )
  }

  {
    selectedIndex,
    highlightedIndex,
    getOptionProps,
  }
}
