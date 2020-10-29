type containerProps = {
  role: string; 
  tabIndex: number;
  onKeyDown(event: any): void;
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
