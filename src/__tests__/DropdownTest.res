open ReactTestingLibrary
open Jest
include TestUtils

module DropdownListboxComponent = {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = (~multiSelect=false) => {
    let {
      highlightedIndex,
      menuVisible,
      selectedIndexes,
      getOptionProps,
      getDropdownProps,
      getContainerProps,
    } = Listboxkit.Dropdown.useDropdownListbox(options, ~multiSelect, ())

    let {role, tabIndex, onKeyDown, onFocus, onBlur} = getContainerProps()

    let dropdownProps = getDropdownProps()
    let selectedOption =
      selectedIndexes
      ->Belt.Array.map(index => options->Belt.Array.get(index))
      ->Belt.Array.joinWith(", ", s => Belt.Option.getUnsafe(s))
      ->String.trim
      ->ReasonReact.string

    <div>
      <div
        role=dropdownProps.role
        tabIndex=dropdownProps.tabIndex
        onClick=dropdownProps.onClick
        onKeyDown=dropdownProps.onKeyDown>
        {selectedOption}
        <div hidden={!menuVisible} role tabIndex onKeyDown onFocus onBlur>
          {options
          |> Array.mapi((index, option) => {
            let {ariaSelected, onClick, role} = getOptionProps(index)
            let highlighted = highlightedIndex == index

            <div key=option onClick onKeyDown role ariaSelected>
              {(highlighted ? `* ${option}` : option) |> React.string}
            </div>
          })
          |> React.array}
        </div>
      </div>
    </div>
  }
}

let component = (~multiSelect=false, ()) => <DropdownListboxComponent multiSelect />

test("select option when clicked", () => {
  let component = component() |> render
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.click
  component |> getByRole(~matcher=#Str("listbox")) |> expect |> toBeVisible |> assertAndContinue

  component
  |> getByRole(
    ~matcher=#Str("option"),
    ~options=DomTestingLibrary.ByRoleQuery.makeOptions(~name="Blue", ()),
  )
  |> FireEvent.click

  component |> getByRole(~matcher=#Str("button")) |> expect |> toHaveTextContent(#Str("Blue"))
})

test("show listbox when pressing arrow down", () => {
  let component = component() |> render
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressDown
  component |> getByRole(~matcher=#Str("listbox")) |> expect |> toBeVisible
})

test("show listbox when pressing arrow up", () => {
  let component = component() |> render
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressUp
  component |> getByRole(~matcher=#Str("listbox")) |> expect |> toBeVisible
})

test("allow multiple selection when multiSelect is true", () => {
  let component = component(~multiSelect=true, ()) |> render

  component |> getByRole(~matcher=#Str("button")) |> FireEvent.click
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressDown
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressSpace
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.click
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressDown
  component |> getByRole(~matcher=#Str("button")) |> FireEvent.pressSpace

  component
  |> getByRole(
    ~matcher=#Str("button"),
    ~options=DomTestingLibrary.ByRoleQuery.makeOptions(~name="Red, Green", ()),
  )
  |> expect
  |> toBeInTheDocument
})
