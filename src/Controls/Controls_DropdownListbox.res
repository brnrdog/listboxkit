type controls = {
  highlightedIndex : int,
  menuVisible      : bool,
  selectedIndex    : int,
  hideMenu         : unit => unit,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  selectHighlighted: unit => unit,
  showMenu         : unit => unit,
}

let useControls = (~size) => {
  let (menuVisible, setMenuVisible) = React.useState(() => false)
  
  let showMenu          = () => setMenuVisible(_ => true)
  let hideMenu          = () => setMenuVisible(_ => false)

  let {
    highlightedIndex,
    selectedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev, 
    selectHighlighted,
  }: Controls_Listbox.controls = Controls_Listbox.useControls(~size)

  {
    highlightedIndex,
    menuVisible,
    selectedIndex,
    hideMenu,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev, 
    selectHighlighted,
    showMenu,
  }
}
