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
  selectedIndex    : int,
  selectedIndexes  : array<int>,
  selectHighlighted: unit => unit,
  selectIndex      : int => unit,
  selectNext       : unit => unit,
  selectPrev       : unit => unit,
  showMenu         : unit => unit,
}

let useControls = (~multiSelect=false, ~size) => {
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
  } = Controls_Listbox.useControls(~multiSelect, ~size)
  let (menuVisible, setMenuVisible) = React.useState(() => false)
  let showMenu = () => setMenuVisible(_ => true)
  let hideMenu = () => setMenuVisible(_ => false)

  let selectIndex = index => {
    selectIndex(index)
    hideMenu()
  }

  {
    hideMenu         : hideMenu,
    highlightedIndex : highlightedIndex,
    highlightFirst   : highlightFirst,
    highlightIndex   : highlightIndex,
    highlightLast    : highlightLast,
    highlightNext    : highlightNext,
    highlightPrev    : highlightPrev,
    menuVisible      : menuVisible,
    resetHighlighted : resetHighlighted,
    selectedIndex    : selectedIndex,
    selectedIndexes  : selectedIndexes,
    selectHighlighted: selectHighlighted,
    selectIndex      : selectIndex,
    selectNext       : selectNext,
    selectPrev       : selectPrev,
    showMenu         : showMenu,
  }
}
