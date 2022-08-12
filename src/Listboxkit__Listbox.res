type listboxContainerProps = {
  role: string,
  tabIndex: int,
  onBlur: ReactEvent.Focus.t => unit,
  onKeyDown: ReactEvent.Keyboard.t => unit,
  onFocus: ReactEvent.Focus.t => unit,
}

type listboxOptionProps = {
  @as("aria-selected")
  ariaSelected: bool,
  role: string,
  onClick: ReactEvent.Mouse.t => unit,
}

type listbox = {
  highlightedIndex: int,
  selectedIndex: int,
  selectedIndexes: array<int>,
  getContainerProps: unit => listboxContainerProps,
  getOptionProps: int => listboxOptionProps,
}

let noop = () => ()

let useFirstRender = () => {
  let isFirst = React.useRef(true)

  if isFirst.current {
    isFirst.current = false
    true
  } else {
    isFirst.current
  }
}

let useUpdateEffect1 = (effect, deps) => {
  let isFirstRender = useFirstRender()

  React.useEffect1(() => {
    isFirstRender ? () : effect()
    None
  }, deps)
}

let useListbox = (options, ~multiSelect=false, ~onChange=?, ()) => {
  let size = options->Belt.Array.length
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

  useUpdateEffect1(() => {
    switch onChange {
    | None => ()
    | Some(onChange) => onChange(selectedIndexes)
    }
  }, [selectedIndexes])

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
      ~hideMenu=noop,
      ~highlightFirst,
      ~highlightLast,
      ~highlightNext,
      ~highlightPrev,
      ~menuVisible=true,
      ~selectHighlighted,
      ~selectNext,
      ~selectPrev,
      ~showMenu=noop,
    ),
  }

  {
    getContainerProps: getContainerProps,
    getOptionProps: getOptionProps,
    highlightedIndex: highlightedIndex,
    selectedIndex: selectedIndex,
    selectedIndexes: selectedIndexes,
  }
}
