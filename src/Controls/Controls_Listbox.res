type controls = {
  highlightedIndex : int,
  selectedIndexes  : array<int>,
  highlightIndex   : int => unit,
  highlightFirst   : unit => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  resetHighlighted : unit => unit,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
}

module Navigation = {
  let firstIndex = _index => 0
  let lastIndex  = (~size, _index)=> size - 1
  let nextIndex  = (~size, index) => size - index == 1 ? 0 : index + 1
  let prevIndex  = (~size, index) => index <= 0 ? size - 1 : index - 1
  let reset      = (_index) => -1;
}

let equals = x => y => x == y
let diff   = x => y => x != y

let selectIndex = (
  ~multiSelect,
  ~setHighlightedIndex, 
  ~setSelectedIndexes, 
  index
) => {
  open Belt.Array

  setHighlightedIndex(_ => index)

  setSelectedIndexes(selectedIndexes => {
    multiSelect ? (index |> equals |> some(selectedIndexes)
    ? keep(selectedIndexes, diff(index)) 
    : concat(selectedIndexes, [index])) : [index]
  })
  
  ()
}

let useControls = (~multiSelect = false, ~size) => {
  let (selectedIndexes, setSelectedIndexes)   = React.useState(() => [])
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)

  let highlightIndex = i  => setHighlightedIndex(_ => i)
  let highlightFirst = _  => setHighlightedIndex(Navigation.firstIndex)
  let highlightLast  = _  => setHighlightedIndex(Navigation.lastIndex(~size))
  let highlightNext  = () => setHighlightedIndex(Navigation.nextIndex(~size))
  let highlightPrev  = () => setHighlightedIndex(Navigation.prevIndex(~size))
  let resetHighlighted = () => setHighlightedIndex(Navigation.reset)
  
  let selectHighlighted = () => selectIndex(
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
    ~multiSelect,
    highlightedIndex
  )

  let selectIndex = selectIndex(
    ~multiSelect,
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
  )
    
  {
    highlightIndex,
    highlightedIndex,
    highlightFirst,
    highlightLast,
    highlightNext,
    highlightPrev,
    resetHighlighted,
    selectedIndexes,
    selectHighlighted,
    selectIndex,
  }
}
