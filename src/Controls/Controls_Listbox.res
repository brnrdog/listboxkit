type controls = {
  highlightedIndex : int,
  highlightFirst   : unit => unit,
  highlightIndex   : int => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  resetHighlighted : unit => unit,
  selectedIndexes  : array<int>,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
  selectNext       : unit => unit,
  selectPrev       : unit => unit,
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
  ~force = false,
  ~multiSelect,
  ~setHighlightedIndex, 
  ~setSelectedIndexes,
  index
) => {
  open Belt.Array

  setHighlightedIndex(_ => index)

  setSelectedIndexes(selectedIndexes => {
    let isIncluded = index |> equals |> some(selectedIndexes)

    switch (multiSelect, force, isIncluded) {
    | (true, true, true)   => selectedIndexes
    | (true, true, false)  => concat(selectedIndexes, [index])
    | (true, false, true)  => keep(selectedIndexes, diff(index))
    | (true, false, false) => concat(selectedIndexes, [index])
    | (false, true, true)  => selectedIndexes
    | (false, false, false)=> []
    | (false, false, true) => []
    | (false, true, false) => [index]
    }
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

  let selectIndex = selectIndex(
    ~multiSelect,
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
  )
  
  let selectHighlighted = () => selectIndex(highlightedIndex)

  let selectNext = () => {
    selectIndex(highlightedIndex, ~force=true)
    selectIndex(highlightedIndex + 1, ~force=true)
  }

  let selectPrev = () => {
    if (highlightedIndex > 0) {
      selectIndex(highlightedIndex)
      selectIndex(highlightedIndex - 1)
    }
  }
    
  {
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
  }
}
