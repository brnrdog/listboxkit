type controls = {
  highlightedIndex : int,
  menuVisible      : bool,
  selectedIndexes  : array<int>,
  hideMenu         : unit => unit,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
  showMenu         : unit => unit,
}

let useControls = (~size) => {
  let (menuVisible, setMenuVisible) = React.useState(() => false)
  
  let showMenu = () => setMenuVisible(_ => true)
  let hideMenu = () => setMenuVisible(_ => false)

  let {
    highlightedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
  }: Controls_Listbox.controls = Controls_Listbox.useControls(~size)

  {
    highlightedIndex,
    menuVisible,
    selectedIndexes,
    hideMenu,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev,
    selectHighlighted,
    selectIndex,
    showMenu,
  }
}
