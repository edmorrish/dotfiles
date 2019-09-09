const SPACEBARHOLDTIME = 100
const CLEAREDSPACE = 'cleared_space'
const SPACEMODIFIER = 'spacebar_modifier'
const keyList = ['semicolon','a','s','d','f','g','h','j','k','l']

const setVariable = (name, value) => ({
  set_variable: {
    name,
    value,
  }
})

const varIf = (name, value) => ({
  type: 'variable_if',
  name,
  value,
})

const spacebar = {
  type: 'basic',
  from: {
    key_code: 'spacebar',
    modifiers: {
      mandatory: [],
      optional: ['any'],
    }
  },
  parameters: {
    'basic.to_if_held_down_threshold_milliseconds': SPACEBARHOLDTIME
  },
  to: [
    {
      key_code: 'spacebar'
    },
    setVariable(CLEAREDSPACE, 0)
  ],
  to_if_held_down: [
    setVariable(SPACEMODIFIER, 1)
  ],
  to_after_key_up: [
    setVariable(SPACEMODIFIER, 0)
  ]
}

const keymap = (from, to) => ([{
  type: 'basic',
  from: {
    key_code: from,
    modifiers: {
      mandatory: [],
      optional: [ 'left_shift' ]
    }
  },
  to: [
    {
      key_code: to
    }
  ],
  conditions: [
    varIf(SPACEMODIFIER, 1),
    varIf(CLEAREDSPACE, 1)
  ]
},
{
  type: 'basic',
  from: {
    key_code: from,
    modifiers: {
      mandatory: [],
      optional: [ 'left_shift' ]
    }
  },
  to: [
    {
      key_code: 'delete_or_backspace'
    },
    {
      key_code: to
    },
    setVariable(CLEAREDSPACE, 1)
  ],
  conditions: [
    varIf(SPACEMODIFIER, 1)
  ]
}])

const keys = keyList.map((key, idx) => keymap(key, idx.toString())).reduce((acc, val) => [...val, ...acc])

const full = {
  title: 'HomeNumbersGen',
  rules: [
    {
      description: 'Space + home position keys to numbers GENERATED',
      manipulators: [
        spacebar,
        ...keys,
        ...keymap("quote", "hyphen"),
      ]
    }
  ]
}


console.log(JSON.stringify(full, null, 4))
