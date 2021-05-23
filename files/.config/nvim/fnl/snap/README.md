# Snap

A small fast extensible finder system for neovim.

- Small api
- Async by default
- Uses producer, consumer, filter, score, sort coroutine pattern

## Getting Started

### Installation

### Usage

The following show a few usage patterns, with different `get_results` functions representing common approaches.

#### Static lists

```lua
snap.run {
  get_results = function ()
    return {"Result 1", "Result 2"}
  end
  on_select = print
}
```

#### Filtered lists

```lua
snap.run {
  get_results = snap.filter(function ()
    return {"Result 1", "Result 2"}
  end)
  on_select = print
}
```

### Using `snap.io.spawn` to implement grep with `ripgrep`

Shows usage of `snap.io.spawn` and the usage of the `message` api.

```lua
snap.run {
  get_results = function(request)
    local cwd = snap.yield(vim.fn.getcwd)
    for data, err, kill in io.spawn("rg", {"--vimgrep", request.filter}, cwd) do
      if request.cancel then
        kill()
        coroutine.yield(nil)
      elseif (err ~= "") then
        coroutine.yield(nil)
      elseif (data == "") then
        coroutine.yield({})
      else
        coroutine.yield(vim.split(data, "\n", true))
      end
    end
    return nil
  end
  on_select = print
}
```
### Using non-fast nvim apis

A baisc example that returns open buffers with the default filter and score attached.

```lua
snap.run {
  get_results = snap.filter_with_score(function()
    -- Get the buffers using a slow nvim call
    local buffers = snap.yield(vim.api.nvim_list_bufs)
    -- Map over the buffers to get their names
    -- again using a slow nvim call in each
    return vim.tbl_map(function(bufnr)
      -- slow call
      return snap.yield(function() return vim.fn.bufname(bufnr) end)
    end, buffers)
  end),
  on_select = print
}
```

## Basic API

### `snap.run`

```typescript
{
  // Get the results to display
  get_results: (request: {filter: string}) => yield<itable<string> | itable<meta-result> | function | nil>;

  // Called on select
  on_select: (selection: string) => nil;

  // Optional prompt displayed to the user
  prompt?: string;

  // Optional function that enables multiselect
  on_multiselect?: (selections: itable<string>) => nil;

  // Optional function configuring the results window
  layout?: () => {
    width: number;
    height: number;
    row: number;
    col: number;
  };
};
```

## Concepts

To understand the API design of `snap` we must first understand the usage of coroutines in Lua, and the producer, consumer, filter pattern of `get_results` that `snap` requires.

### Yield types

There are 3 available types that a `get_results` function can yield:

- `itable<string>`
- `itable<meta-result>`
- `function`
- `nil`

Each yield type constuitutes a distinct meaning to `snap`.

#### Yielding `itable<string>`

For each `itable<string>`  yielded (or returned as the last value of `get_results`) to `snap` from `get_results`, `snap` will accumulate the `string` values of the table and display them in the results buffer.

##### Example

```lua
local function get_results(message)
  coroutine.yield({"Result 1", "Result 1"})
  coroutine.yield({"Result 3", "Result 4"})
end
```

This `get_results` function results in a table of 4 values displayed, but given there are two yields, in between these yields `nvim` has an opputunity to process more input.

One can see how this functionality allows for results of spawned processes to progressively yield thier results while avoiding blocking user input, and enabling the cancelation of said spawned processes.

#### Yielding `itable<meta-result>`

Results at times need to be decorated with additional information, e.g. a sort score.

`snap` makes use of tables (with an attached metatable implementing `__tostring`) to represent results with meta data.

The following shows how to add results with additional information. And because `snap` automatically sorts results with `score` meta data, the following with be ordered accordingly.

```lua
local function get_results(message)
  coroutine.yield({
    snap.with_meta("Higher rank", "score", 10),
    snap.with_meta("Lower rank", "score", 1),
    snap.with_meta("Mid rank", "score", 5)
  })
end
```

#### Yielding `function`

Given that `get_results` is by design run when `fast-mode` is true. One needs an ability to at times get the result of a blocking `nvim` function, such as many of `nvim` basic functions, e.g. `vim.fn.getcwd`. As such `snap` provides the ability to `yield` a function, have its execution run with `vim.schedule` and its resulting value returned.

##### Example

```lua
local function get_results(message)
  -- Yield a function to get its result
  local cwd = snap.yield(vim.fn.cwd)
  -- Now we have the cwd we can yield itable<string>
  coroutine.yield({cwd})
end
```

This results in a single result being displayed in the result buffer, in particular the `cwd`.

#### Yielding `nil`

Yielding nil signals to `snap` that there are not more results, and the coroutine is dead. `snap` will finish resuming the `coroutine` when nil is encounted.

```lua
local function get_results(message)
  coroutine.yield({"Result 1", "Result 1"})
  coroutine.yield(nil)
  -- Doesn't proces this, as coroutine is dead
  coroutine.yield({"Result 3", "Result 4"})
end
```

See examples.lua for more examples.

## Advanced API (for developers)

### `snap.meta_result`

TODO

### `snap.with_meta`

TODO

### `snap.resume`

Resumes a passed coroutine while handling non-fast API requests.

### `snap.yield`

Makes getting values from yield easier by skiping first coroutine.yield return value.

### `snap.cache`

Caches results. Used when results are collected by process on first open, but just processed on subsequent calls.

### `snap.filter`

Filters by `request.filter`.

### `snap.score`

TODO

### `snap.filter_with_score`

TODO

### `snap.layouts.centered`
### `snap.layouts.bottom`
### `snap.layouts.top`
