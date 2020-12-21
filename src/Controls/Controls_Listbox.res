type controls = {
  highlightedIndex : int,
  highlightFirst   : unit => unit,
  highlightIndex   : int  => unit,
  highlightLast    : unit => unit,
  highlightNext    : unit => unit,
  highlightPrev    : unit => unit,
  resetHighlighted : unit => unit,
  selectedIndex    : int,
  selectedIndexes  : array<int>,
  selectHighlighted: unit => unit,
  selectIndex      : int  => unit,
  selectNext       : unit => unit,
  selectPrev       : unit => unit,
}

module Navigation = {
  let firstIndex = _index => 0
  let lastIndex  = (~size, _index)=> size - 1
  let nextIndex  = (~size, index) => {
    size - index == 1 ? 0 : index + 1
  }
  let prevIndex  = (~size, index) => index <= 0 ? size - 1 : index - 1
  let reset      = (_index) => -1;
}

let firstIndex = i => i->Belt.Array.get(0)->Belt.Option.getWithDefault(-1)
let equals = x => y => x == y
let diff   = x => y => x != y

let selectIndex = (
  ~keep = false,
  ~multiSelect,
  ~setHighlightedIndex, 
  ~setSelectedIndexes,
  index
) => {
  setHighlightedIndex(_ => index)

  setSelectedIndexes(selectedIndexes => {
    let isIncluded = index |> equals |> Belt.Array.some(selectedIndexes)

    switch (multiSelect, keep, isIncluded) {
    | (true, true, true)   => selectedIndexes
    | (true, true, false)
    | (true, false, false) => selectedIndexes->Belt.Array.concat([index])
    | (true, false, true)  => selectedIndexes->Belt.Array.keep(diff(index))
    | (false, true, true)  => selectedIndexes
    | (false, false, true) => []
    | (false, false, false)
    | (false, true, false) => [index]
    }
  })
  
  ()
}

let useControls = (~multiSelect = false, ~size) => {
  let (selectedIndexes, setSelectedIndexes)   = React.useState(() => [])
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)

  let highlightIndex = i    => setHighlightedIndex(_ => i)
  let highlightFirst = _    => setHighlightedIndex(Navigation.firstIndex)
  let highlightLast  = _    => setHighlightedIndex(Navigation.lastIndex(~size))
  let highlightNext  = ()   => setHighlightedIndex(Navigation.nextIndex(~size))
  let highlightPrev  = ()   => setHighlightedIndex(Navigation.prevIndex(~size))
  let resetHighlighted = () => setHighlightedIndex(Navigation.reset)

  let selectIndex = selectIndex(
    ~multiSelect,
    ~setSelectedIndexes, 
    ~setHighlightedIndex,
  )
  let selectHighlighted = () => selectIndex(highlightedIndex)
  let selectNext = () => {
    selectIndex(Navigation.nextIndex(~size, highlightedIndex), ~keep=true)
  }
  let selectPrev = () => {
    selectIndex(Navigation.prevIndex(~size, highlightedIndex), ~keep=true)
  }

  let selectedIndex = selectedIndexes->firstIndex
    
  {
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
  }
}
