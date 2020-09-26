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
      getOptionProps
    }: Listbox.listbox = Listbox.useListbox(~options)

    <ul> 
      {
        options 
        |> Array.mapi((index, option) => {
          let {
            ariaSelected,
            onClick, 
            onKeyDown,
            role,
            tabIndex
          }: Listbox.optionProps = getOptionProps(index)
          let highlighted =  highlightedIndex == index

          <li key=option onClick onKeyDown role ariaSelected tabIndex>
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
  let pressEnter = FireEvent.keyDown(~eventInit={"key": "Enter"})
  let pressSpace = FireEvent.keyDown(~eventInit={"key": " "})
}

let getOption = (name) => getByRole(
  ~matcher=#Str("option"),
  ~options=DomTestingLibrary.ByRoleQuery.makeOptions(~name, ()),
)

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

test("sets option aria-selected to true when clicked", () => {
  let component = render(component)
  
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

  component
  |> getOption("Red") 
  |> FireEvent.click

  component 
  |> getOption("* Red") 
  |> FireEvent.pressDown
  
  component 
  |> getOption("* Green") 
  |> FireEvent.pressDown

  component 
  |> getOption("* Blue") 
  |> FireEvent.pressDown
  
  component
  |> getOption("* Red")
  |> expect
  |> toBeInTheDocument
})

test("highlights prev option when pressing arrow up", () => {
  let component = render(component)

  component 
  |> getOption("Red")
  |> FireEvent.click
  
  component 
  |> getOption("* Red") 
  |> FireEvent.pressUp

  component 
  |> getOption("* Blue") 
  |> FireEvent.pressUp

  component 
  |> getOption("* Green") 
  |> FireEvent.pressUp

  component 
  |> getOption("* Red") 
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
  |> getOption("* Red")
  |> FireEvent.pressEnter

  component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="false")
  |> _ => ()

  component
  |> getOption("* Red")
  |> FireEvent.pressEnter

 component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="true") 
})

