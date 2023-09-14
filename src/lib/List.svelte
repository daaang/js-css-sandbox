<script>
  export let title = 'My to-do list'

  import { nanoid } from 'nanoid'
  import { tick } from 'svelte'
  import Item from './Item.svelte'

  let newItem = ''
  let announcement = ''

  let items = [{
    id: nanoid(),
    summary: 'Become as gods',
    due: true,
  }, {
    id: nanoid(),
    summary: 'Acquire ingredients',
    due: false,
  }, {
    id: nanoid(),
    summary: 'It occurs to me that it would be a good idea to have at least one very long item on the list. It will demonstrate the behavior I can expect when an item on the list spans multiple lines and takes up all the space that has to require. I should be able to use that and design around it in order to ensure that even wordy to-do items appear as helpfully as possible.',
    due: true,
  }, {
    id: nanoid(),
    summary: 'Pretend to do “bullet journaling”',
    due: true,
  }]

  //items = []

  async function addNewItem(e) {
    items = [...items, {
      id: nanoid(),
      summary: newItem,
      due: true,
    }]

    announcement = 'New item added: ' + newItem

    newItem = ''
    await tick()
    document.querySelector('#new-item-input').focus()
  }

  function deleteItem(id) {
    let index = items.findIndex(item => item.id === id)
    if (index > -1) {
      let summary = items[index].summary
      items = items.slice(0, index).concat(items.slice(index + 1))
      document.querySelector('#list-label').focus()
      announcement = 'Deleted item: ' + summary
    }
  }

  function showDetail(id) {
    let item = items.find(i => i.id === id)
    alert(item.summary)
  }
</script>

<section aria-labelledby="list-label">
  <h1 id="list-label" tabindex="-1">{title}</h1>

  <ul>
    {#each items as item (item.id)}
      <Item {...item}
            on:delete={() => deleteItem(item.id)}
            on:showdetails={() => showDetail(item.id)}/>
    {/each}
  </ul>

  <div class="empty-state">
    <p>Either you're done, or you might want to add to the list.</p>
  </div>

  <form on:submit={addNewItem}>
    <input type="text" id="new-item-input"
           bind:value={newItem}
           placeholder="e.g. Become as gods"
           aria-invalid={newItem === '' ? 'true' : ''}
           aria-label="Write a new item"/>
    <button type="submit" disabled={newItem === '' ? 'true' : ''}>Add</button>
  </form>

  <div role="status" aria-live="polite" class="vh">{announcement}</div>
</section>

<div class="whwhw">

</div>

<style>
  ul {
    margin: 0;
    padding: 0;
  }

  ul:empty, .empty-state {
    display: none;
  }

  ul:empty + .empty-state {
    display: block;
  }

  section {
    /* I stole this font list from tachyons 4.12.0 sans-serif */
    font-family: -apple-system, BlinkMacSystemFont,
                 'avenir next', avenir,
                 'helvetica neue', helvetica,
                 ubuntu,
                 roboto, noto,
                 'segoe ui', arial,
                 sans-serif;
  }

  @media screen and (min-width: 30em) {
    section {
      width: 60%;
      min-width: 30em;
      max-width: 60em;
      margin: auto;
    }
  }

  /* Different browsers style their placeholder text differently >:\ */
  ::-webkit-input-placeholder {
    color: #444;
    font-style: italic;
  }
  ::-moz-placeholder {
    color: #444;
    font-style: italic;
  }
  :-ms-input-placeholder {
    color: #444;
    font-style: italic;
  }
  :-moz-placeholder {
    color: #444;
    font-style: italic;
  }

  .vh {
    position: absolute !important;
    padding: 0 !important;
    border: 0 !important;
    width: 1px !important;
    height: 1px !important;
    clip: rect(1px, 1px, 1px, 1px);
    overflow: hidden;
  }

  [tabindex="-1"] {
    outline: none;
  }
</style>
