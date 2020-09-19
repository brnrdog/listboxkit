type controls = {
  highlightedIndex : int,
  selectedIndex    : int,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  selectIndex      : int => unit,
  selectHighlighted: unit => unit,
}

let rec nextIndex = (~size, ~selectedIndex, index) => {
  let next = size - index == 1 ? 0 : index + 1;
  next == selectedIndex ? nextIndex(~size, ~selectedIndex, next) : next
}

let rec prevIndex = (~size, ~selectedIndex, index) => {
  let prev = index == 0 ? size - 1 : index - 1
  prev == selectedIndex ? prevIndex(~size, ~selectedIndex, prev) : prev
}

let useControls = (~size) => {
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)
  let (selectedIndex, setSelectedIndex)       = React.useState(() => -1)

  let highlightFirst    = _ => setHighlightedIndex(_ => 0)
  let highlightLast     = _ => setHighlightedIndex(_ => size - 1)
  let highlightNext     = () => setHighlightedIndex(nextIndex(~size, ~selectedIndex))
  let highlightPrev     = () => setHighlightedIndex(prevIndex(~size, ~selectedIndex))
  let selectHighlighted = () => setSelectedIndex(_ => highlightedIndex)
  let selectIndex       = index => setSelectedIndex(_ => index)

  {
    highlightedIndex,
    selectedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev,
    selectIndex,
    selectHighlighted,
  }
}
