open ReactTestingLibrary
open Jest
include TestUtils

@send external focus: Dom.element => unit = "focus"

module DropdownListboxComponent = {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = (~multiSelect=false, ~highlightFirstOnOpen=false) => {
    let {
      highlightedIndex,
      menuVisible,
      selectedIndexes,
      getOptionProps,
      getDropdownProps,
      getContainerProps,
    } = Listboxkit.useDropdownListbox(options, ~multiSelect, ~highlightFirstOnOpen, ())

    let {role, tabIndex, onKeyDown, onFocus} = getContainerProps()

    let dropdownProps = getDropdownProps()
    let selectedOption =
      selectedIndexes
      ->Belt.Array.map(index => options->Belt.Array.get(index))
      ->Belt.Array.joinWith(", ", s => Belt.Option.getUnsafe(s))
      ->String.trim
      ->React.string
    <div>
      <button
        role=dropdownProps.role
        tabIndex=dropdownProps.tabIndex
        onClick=dropdownProps.onClick
        onKeyDown=dropdownProps.onKeyDown
        onBlur=dropdownProps.onBlur>
        {selectedOption}
      </button>
      <ul hidden={!menuVisible} role tabIndex onKeyDown onFocus>
        {options
        |> Array.mapi((index, option) => {
          let {ariaSelected, onClick, role} = getOptionProps(index)
          let highlighted = highlightedIndex == index

          <li key=option onClick onKeyDown role ariaSelected>
            {(highlighted ? `* ${option}` : option) |> React.string}
          </li>
        })
        |> React.array}
      </ul>
      <div tabIndex={0}> {"Focus out"->React.string} </div>
    </div>
  }
}

let component = (~multiSelect=false, ~highlightFirstOnOpen=false, ()) =>
  <DropdownListboxComponent multiSelect highlightFirstOnOpen />

test("select option when clicked", () => {
  let component = component() |> render

  component->getByRole(~matcher=#Str("combobox"))->FireEvent.click

  component->getByRole(~matcher=#Str("listbox"))->expect->toBeVisible->assertAndContinue
  component
  ->getByRole(~matcher=#Str("option"), ~options=makeByRoleOptions(~name="Blue", ()))
  ->FireEvent.click

  component->getByRole(~matcher=#Str("combobox"))->expect->toHaveTextContent(#Str("Blue"))
})

test("show listbox when pressing arrow down", () => {
  let component = component() |> render
  component->getByRole(~matcher=#Str("combobox"))->FireEvent.pressDown
  component->getByRole(~matcher=#Str("listbox"))->expect->toBeVisible
})

test("show listbox when pressing arrow up", () => {
  let component = component() |> render
  component->getByRole(~matcher=#Str("combobox"))->FireEvent.pressUp
  component->getByRole(~matcher=#Str("listbox"))->expect->toBeVisible
})

test("allow multiple selection when multiSelect is true", () => {
  let component = component(~multiSelect=true, ()) |> render
  let button = component->getByRole(~matcher=#Str("combobox"))

  button->FireEvent.click
  component->getOption("Red")->FireEvent.click
  button->FireEvent.click
  component->getOption("Green")->FireEvent.click

  component->getByRole(~matcher=#Str("combobox"))->expect->toHaveTextContent(#Str("Red, Green"))
})

test("hide listbox when focusing out from listbox", () => {
  let screen = component()->render

  screen->getByRole(~matcher=#Str("combobox"))->FireEvent.pressDown
  screen->getByRole(~matcher=#Str("listbox"))->expect->toBeVisible->assertAndContinue
  screen->getByText(~matcher=#Str("Focus out"))->FireEvent.click
  screen->queryAllByRole(~matcher=#Str("listbox"))->Array.length->Expect.expect->toEqual(0)
})

test("highlight first option on open with keyboard down when highlightFirstOnOpen is true", () => {
  let component = <DropdownListboxComponent highlightFirstOnOpen=true /> |> render
  component->getByRole(~matcher=#Str("combobox"))->focus
  FireEvent.pressKeyboardDown()
  component->getOption("* Red")->expect->toBeVisible
})
test("highlight first option on open with keyboard enter when highlightFirstOnOpen is true", () => {
  let component = <DropdownListboxComponent highlightFirstOnOpen=true /> |> render
  component->getByRole(~matcher=#Str("combobox"))->focus
  FireEvent.pressKeyboardEnter()
  component->getOption("* Red")->expect->toBeVisible
})
test("highlight first option on open with keyboard up when highlightFirstOnOpen is true", () => {
  let component = <DropdownListboxComponent highlightFirstOnOpen=true /> |> render
  component->getByRole(~matcher=#Str("combobox"))->focus
  FireEvent.pressKeyboardUp()
  component->getOption("* Red")->expect->toBeVisible
})
test("highlight first option on open with keyboard space when highlightFirstOnOpen is true", () => {
  let component = <DropdownListboxComponent highlightFirstOnOpen=true /> |> render
  component->getByRole(~matcher=#Str("combobox"))->focus
  FireEvent.pressKeyboardSpace()
  component->getOption("* Red")->expect->toBeVisible
})

test("highlight first option on open with click when highlightFirstOnOpen is true", () => {
  let component = <DropdownListboxComponent highlightFirstOnOpen=true /> |> render
  component->getByRole(~matcher=#Str("combobox"))->FireEvent.click
  component->getOption("* Red")->expect->toBeVisible
})
