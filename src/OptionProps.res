let ariaSelected = (~index, ~selectedIndex) => index == selectedIndex
let onClick = (~index, ~selectIndex, _event) => selectIndex(index)