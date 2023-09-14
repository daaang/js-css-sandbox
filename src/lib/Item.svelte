<script>
  export let summary
  export let due = true
  export let checked = false

  import { createEventDispatcher } from 'svelte'
  const dispatch = createEventDispatcher()

  $: liClass = checked ? 'complete' : (due ? 'due' : 'optional')

  function deleteThis() {
    dispatch('delete')
  }

  function showDetails(e) {
    dispatch('showdetails')
    e.preventDefault()
  }
</script>

<li class={liClass}>
  <label class="checkbox">
    <input type="checkbox" bind:checked={checked}/>
    <span class="indicator"/>
    <button on:click={showDetails}>{summary}</button>
  </label>
  <button class="right-button"
          aria-label={'delete ' + summary}
          on:click={deleteThis}>&times;</button>
</li>

<style>
  li {
    display: grid;
    grid-template-columns: 1fr 1.5rem;
    list-style: none;
    margin: 0.5em;
    padding: 0.5em;
    border: 0.25em solid #786a06;
    border-radius: 0.5em;
    color: #111111;
    background-color: #fbf1a9;
  }

  li.optional {
    background-color: #9eebcf;
    border-color: #137552;
  }

  li.complete {
    background-color: #eeeeee;
    border-color: #999999;
  }

  button.checkbox {
    float: left;
    margin-right: 0.5em;
  }

  div.float-right {
    float: right;
  }

  label.checkbox {
    display: grid;
    grid-template-columns: 2rem 1fr;
  }

  label.checkbox button {
    margin: 0 0.5rem 0 0;
    padding: 0;
    cursor: pointer;
    border: none;
    background: transparent;
    text-align: left;
  }

  label.checkbox input {
    position: absolute;
    opacity: 0;
    z-index: -1;
  }

  button.right-button {
    width: 1.375rem;
    height: 1.375rem;
  }

  label.checkbox span.indicator {
    top: 0;
    left: 0;
    display: block;
    width: 1.375rem;
    height: 1.375rem;
    line-height: 1rem;
    font-size: 65%;
    text-align: center;
    color: #eeeeee;
    background-color: #eeeeee;
    background-size: 50% 50%;
    background-position: center center;
    background-repeat: no-repeat;
    border-radius: 0.25rem;
    pointer-events: none;
    user-select: none;
  }

  li.due label.checkbox input:focus ~ span.indicator {
    box-shadow: 0 0 0 0.075rem #fbf1a9, 0 0 0 0.2rem #786a06;
  }

  li.optional label.checkbox input:focus ~ span.indicator {
    box-shadow: 0 0 0 0.075rem #9eebcf, 0 0 0 0.2rem #137552;
  }

  li.complete label.checkbox input:focus ~ span.indicator {
    box-shadow: 0 0 0 0.075rem #eeeeee, 0 0 0 0.2rem #999999;
  }

  label.checkbox input:checked ~ span.indicator {
    color: #999999;
    background-color: #999999;

    /* <?xml version="1.0" encoding="utf-8"?>
     * <!-- Generator: Adobe Illustrator 17.1.0, SVG Export Plug-In .
     *                                  SVG Version: 6.00 Build 0)  -->
     * <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
     *              "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
     * <svg version="1.1"
     *      id="Layer_1"
     *      xmlns="http://www.w3.org/2000/svg"
     *      xmlns:xlink="http://www.w3.org/1999/xlink"
     *      x="0px"
     *      y="0px"
     *      viewBox="0 0 8 8"
     *      enable-background="new 0 0 8 8"
     *      xml:space="preserve">
     *   <path fill="#FFFFFF"
     *         d="M 6.4,1
     *            L 5.7,1.7
     *            L 2.9,4.5
     *            L 2.1,3.7
     *            L 1.4,3
     *            L 0,4.4
     *            l 0.7,0.7
     *            l 1.5,1.5
     *            l 0.7,0.7
     *            l 0.7-0.7
     *            l 3.5-3.5
     *            l 0.7-0.7
     *            L 6.4,1
     *            L 6.4,1
     *            z"/>
     * </svg> */
    background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNy4xLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgOCA4IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCA4IDgiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPHBhdGggZmlsbD0iI0ZGRkZGRiIgZD0iTTYuNCwxTDUuNywxLjdMMi45LDQuNUwyLjEsMy43TDEuNCwzTDAsNC40bDAuNywwLjdsMS41LDEuNWwwLjcsMC43bDAuNy0wLjdsMy41LTMuNWwwLjctMC43TDYuNCwxTDYuNCwxeiINCgkvPg0KPC9zdmc+DQo=);
  }

  /*label.checkbox input:active ~ span.indicator {
    color: #333333;
    background-color: #333333;
  }*/
</style>
