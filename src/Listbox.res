type optionProps = {
  ariaSelected: bool,
  role        : string,
  onClick     : ReactEvent.Mouse.t => unit,
}

type listbox = {
  highlightedIndex: int,
  selectedIndex   : int,
  getOptionProps  : int => optionProps,
}

let useListbox = (~options) => {
  let size = options |> Array.length
  let {
    highlightedIndex,
    selectedIndex,
    selectIndex,
  }: Controls.Listbox.controls = Controls.Listbox.useControls(~size)

  let getOptionProps = index => {
    ariaSelected: selectedIndex == highlightedIndex,
    role: "option",
    onClick: EventHandlers.onClick(~index, ~selectIndex)
  }

  {
    selectedIndex,
    highlightedIndex,
    getOptionProps,
  }
}
