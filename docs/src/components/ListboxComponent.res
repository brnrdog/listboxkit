@react.component
let make = () => {
  let (state, setState) = React.useState(() => [])
  let options = ["Red", "Green", "Blue"]

  let onChange = selectedIndexes => {
    Js.log(selectedIndexes)
    let byIndex = (_, index) => Js.Array2.includes(selectedIndexes, index)
    let updateState = options => setState(_ => options)

    options->Js.Array2.filteri(byIndex)->updateState
  }

  <div>
    {React.string("Selected: " ++ state->Js.Array2.joinWith(", "))}
    <br />
    <br />
    <Listboxkit.ListboxComponent
      onChange={onChange}
      optionClassName="listbox-option"
      className="listbox"
      options
      multiSelect=true
      activeClassName="highlighted"
    />
  </div>
}
