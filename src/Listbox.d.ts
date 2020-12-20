type containerProps = {
  role: string; 
  tabIndex: number;
  onKeyDown(event: any): void;
}

type dropdownProps = {
  role: string; 
  onClick(event: any): void;
}

type optionProps = {
  role: string;
  'aria-selected': boolean;
  onClick(event: any): void;
};

type listbox = {
  highlightedIndex: number;
  selectedIndexes: Array<number>;
  getContainerProps(): containerProps;
  getOptionProps(index: number): optionProps;
}

export function useListbox<A>(options: Array<A>, multi?: boolean): listbox;

type dropdownListbox = {
  highlightedIndex: number;
  menuVisible: boolean;
  selectedIndexes: Array<number>;
  getContainerProps(): containerProps;
  getDropdownProps(): dropdownProps;
  getOptionProps(index: number): optionProps;
  hideMenu(): void;
  showMenu(): void;
}

export function useDropdownListbox<A>(options: Array<A>, multi?: boolean): dropdownListbox;