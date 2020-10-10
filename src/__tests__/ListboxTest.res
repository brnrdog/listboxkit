open Jest
open JestDom
open ReactTestingLibrary

type t = {
  key: string
}

module ListboxComponent = {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = () => {
    let {
      highlightedIndex, 
      getOptionProps,
      getContainerProps,
    }: Listbox.listbox = Listbox.useListbox(~options)

    let { role, tabIndex, onKeyDown } = getContainerProps()

    <ul role tabIndex onKeyDown> 
      {
        options 
        |> Array.mapi((index, option) => {
          let {
            ariaSelected,
            onClick, 
            role,
          }: Listbox.optionProps = getOptionProps(index)
          let highlighted =  highlightedIndex == index

          <li key=option onClick onKeyDown role ariaSelected>
            {(highlighted ? `* ${option}` : option) |> React.string}
          </li>
        }) 
        |> React.array
      } 
    </ul>
  }
}

let component = <ListboxComponent />

module FireEvent = {
  include ReactTestingLibrary.FireEvent

  let pressDown  = FireEvent.keyDown(~eventInit={ "key": "ArrowDown" })
  let pressUp    = FireEvent.keyDown(~eventInit={ "key": "ArrowUp" })
  let pressEnter = FireEvent.keyDown(~eventInit={"key": "Enter" })
  let pressSpace = FireEvent.keyDown(~eventInit={"key": " " })
  let pressEnd   = FireEvent.keyDown(~eventInit={"key": "End" })
  let pressHome  = FireEvent.keyDown(~eventInit={"key": "Home" })
  let pressEsc   = FireEvent.keyDown(~eventInit={"key": "Esc" })
}

let getListbox = getByRole(~matcher=#Str("listbox"))

let getOption = (name) => getByRole(
  ~matcher=#Str("option"),
  ~options=DomTestingLibrary.ByRoleQuery.makeOptions(~name, ()),
)

test("render listbox container", () => {
  render(component)
  |> getListbox
  |> expect
  |> toBeInTheDocument
})

test("renders the option role for 'Red' ", () => {
  render(component)
  |> getOption("Red") 
  |> expect 
  |> toBeInTheDocument
})

test("renders the option role for 'Green'", () => {
  render(component) 
  |> getOption("Green") 
  |> expect 
  |> toBeInTheDocument
})

test("renders the option role for 'Blue'", () => {
  render(component )
  |> getOption("Blue") 
  |> expect 
  |> toBeInTheDocument
})

test("highlights last option when pressing End", () => {
  let component = render(component)

  component
  |> getOption("Red")
  |> FireEvent.pressEnd
  
  component
  |> getOption("* Blue")
  |> expect
  |> toBeInTheDocument
})

test("highlights first option when pressing Home", () => {
  let component = render(component)

  component
  |> getOption("Blue")
  |> FireEvent.pressHome
  
  component
  |> getOption("* Red")
  |> expect
  |> toBeInTheDocument
})

test("sets option aria-selected to true when clicked", () => {
  let component = render(component)

  // Nothing should happen when pressing esc.
  component 
  |> getOption("Red")
  |> FireEvent.pressEsc
  
  component 
  |> getOption("Red") 
  |> FireEvent.click

  component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="true")
})

test("highlights next option when pressing arrow down ", () => {
  let component = render(component) 
  let listbox = component |> getListbox

  // Looping over the options:
  listbox |> FireEvent.pressDown
  listbox |> FireEvent.pressDown
  listbox |> FireEvent.pressDown
  listbox |> FireEvent.pressDown

  component
  |> getOption("* Red") 
  |> expect
  |> toBeInTheDocument
})

test("highlights previous option when pressing arrow up ", () => {
  let component = render(component) 
  let listbox = component |> getListbox

  // Looping over the options:
  listbox |> FireEvent.pressUp
  listbox |> FireEvent.pressUp
  listbox |> FireEvent.pressUp
  listbox |> FireEvent.pressUp

  component
  |> getOption("* Blue") 
  |> expect
  |> toBeInTheDocument
})

test("selecting and unselecting", () => {
  let component = render(component)

  component
  |> getOption("Red")
  |> FireEvent.click

  component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="true")
  |> _ => ()

  component
  |> getListbox
  |> FireEvent.pressEnter

  component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="false")
  |> _ => ()

  component
  |> getListbox
  |> FireEvent.pressSpace

 component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="true") 
})

