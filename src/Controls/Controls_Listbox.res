type controls = {
  highlightedIndex : int,
  selectedIndexes  : array<int>,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
}

module Navigation = {
  let firstIndex = _index => 0
  let lastIndex  = (~size, _index)=> size - 1
  let nextIndex  = (~size, index) => size - index == 1 ? 0 : index + 1
  let prevIndex  = (~size, index) => index <= 0 ? size - 1 : index - 1
}

let equals = x => y => x == y
let diff   = x => y => x != y

let selectIndex = (
  ~setHighlightedIndex, 
  ~setSelectedIndexes, 
  index
) => {
  open Belt.Array

  setHighlightedIndex(_ => index)
  setSelectedIndexes(selectedIndexes => {
    index |> equals |> some(selectedIndexes)
    ? keep(selectedIndexes, diff(index)) 
    : concat(selectedIndexes, [index])
  })
  
  ()
}

let useControls = (~size) => {
  let (selectedIndexes, setSelectedIndexes)   = React.useState(() => [])
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)

  let highlightFirst = _  => setHighlightedIndex(Navigation.firstIndex)
  let highlightLast  = _  => setHighlightedIndex(Navigation.lastIndex(~size))
  let highlightNext  = () => setHighlightedIndex(Navigation.nextIndex(~size))
  let highlightPrev  = () => setHighlightedIndex(Navigation.prevIndex(~size))
  
  let selectHighlighted = () => selectIndex(
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
    highlightedIndex
  )

  let selectIndex = selectIndex(
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
  )
    
  {
    highlightedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
  }
}
