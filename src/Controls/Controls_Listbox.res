type controls = {
  highlightedIndex : int,
  selectedIndex    : int,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  selectHighlighted: unit => unit,
}

let nextIndex = (~size, index) => size - index == 1 ? 0 : index + 1
let prevIndex = (~size, index) => index == 0 ? size - 1 : index - 1

let useControls = (~size) => {
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)
  let (selectedIndex, setSelectedIndex)       = React.useState(() => -1)

  let highlightNext     = () => setHighlightedIndex(nextIndex(~size))
  let highlightPrev     = () => setHighlightedIndex(prevIndex(~size))
  let selectIndex       = index => setSelectedIndex(_ => index)
  let selectHighlighted = () => setSelectedIndex(_ => highlightedIndex)
  let highlightFirst    = _ => setHighlightedIndex(_ => 0)
  let highlightLast     = _ => setHighlightedIndex(_ => size - 1)

  {
    highlightedIndex,
    selectedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev, 
    selectHighlighted,
  }
}