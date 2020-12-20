type controls = {
  hideMenu         : unit => unit,
  highlightedIndex : int,
  highlightFirst   : unit => unit,
  highlightIndex   : int => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  menuVisible      : bool,
  resetHighlighted : unit => unit,
  selectedIndexes  : array<int>,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
  selectNext       : unit => unit,
  selectPrev       : unit => unit,
  showMenu         : unit => unit,
}

let useControls = (~multiSelect = false, ~size) => {
  let {
    highlightedIndex,
    highlightFirst,
    highlightIndex,
    highlightLast,
    highlightNext,
    highlightPrev,
    resetHighlighted,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
    selectNext,
    selectPrev,
  } = Controls_Listbox.useControls(~multiSelect, ~size)
  let (menuVisible, setMenuVisible) = React.useState(() => false)
  let showMenu = () => setMenuVisible(_ => true)
  let hideMenu = () => setMenuVisible(_ => false)

  {
    hideMenu,
    highlightedIndex,
    highlightFirst,
    highlightIndex,
    highlightLast,
    highlightNext,
    highlightPrev,
    menuVisible,
    resetHighlighted,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
    selectNext,
    selectPrev,
    showMenu,
  }
}
