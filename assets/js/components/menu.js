export default menu = (state) => ({
  open: state.open,
  activeIndex: -1,
  activeDescendant: "",
  toggle() {
    this.open = !this.open;
  },
  init(debug = false) {
    debug && console.log("Menu Component Init");
    console.log(state);
  },
  onClickAway() {
    this.open = false;
  },
  onButtonClick() {
    this.toggle();
  },
  onButtonEnter() {
    this.toggle();
  },
  onArrowUp() {},
  onArrowDown() {},
  focusButton() {},
});
